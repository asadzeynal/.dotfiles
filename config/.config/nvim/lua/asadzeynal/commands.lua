local qf_errorformat = "%f:%l:%c: %m,%f:%l: %m,%-G%.%#"
local task_flags = "--silent --color=false"

local function run_qf(cmd)
	local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local spinner_index = 1
	local timer = vim.uv.new_timer()
	local notification
	local running = true

	timer:start(0, 120, function()
		vim.schedule(function()
			if not running then
				return
			end

			notification = vim.notify(spinner[spinner_index] .. " Running: " .. cmd, vim.log.levels.INFO, {
				title = "RunQf",
				id = notification,
				timeout = false,
				history = false,
			})
			spinner_index = spinner_index % #spinner + 1
		end)
	end)

	vim.system({ vim.o.shell, vim.o.shellcmdflag, cmd }, { text = true }, function(result)
		vim.schedule(function()
			running = false
			timer:stop()
			timer:close()

			if notification then
				Snacks.notifier.hide(notification)
			end

			local output = table.concat({ result.stdout or "", result.stderr or "" }, "\n")

			vim.fn.setqflist({}, "r", {
				title = cmd,
				lines = vim.split(output, "\n", { trimempty = true }),
				efm = qf_errorformat,
			})

			local qf_count = #vim.fn.getqflist()

			if result.code ~= 0 and qf_count == 0 then
				vim.notify(cmd .. " exited with code " .. result.code, vim.log.levels.WARN)
			end

			if qf_count > 0 then
				vim.cmd("botright copen")
			else
				vim.notify(cmd .. " finished with no quickfix entries", vim.log.levels.INFO)
			end
		end)
	end)
end

vim.api.nvim_create_user_command("TaskLint", function()
	run_qf("task " .. task_flags .. " lint")
end, {})

vim.api.nvim_create_user_command("TaskTest", function()
	run_qf("task " .. task_flags .. " test")
end, {})

vim.api.nvim_create_user_command("RunQf", function(opts)
	run_qf(opts.args)
end, {
	nargs = "+",
	complete = "shellcmd",
})
