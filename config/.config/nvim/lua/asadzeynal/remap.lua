vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>n", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>p", "<cmd>cprev<CR>zz")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	desc = "Notify when recording a macro",
	group = vim.api.nvim_create_augroup("macro-notify", { clear = true }),
	callback = function(ev)
		local msg
		if ev.event == "RecordingEnter" then
			msg = "Recording @"
		else
			msg = "Done Recording @"
		end
		vim.notify(
			msg .. vim.fn.reg_recording(),
			vim.log.levels.INFO,
			{ title = "Macro", timeout = 10000, hide_from_history = false }
		)
	end,
})
