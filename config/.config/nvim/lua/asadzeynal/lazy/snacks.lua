return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			"folke/trouble.nvim",
		},
		opts = function(_, opts)
			local lazygit_opts = {}
			local ok, local_opts = pcall(require, "asadzeynal.snacks_local")
			if ok then
				lazygit_opts = local_opts.lazygit or {}
			end
			return vim.tbl_deep_extend("force", opts or {}, {
				gitbrowse = {
					url_patterns = {
						["^https://gitlab%.[^/]+/"] = {
							branch = "/-/tree/{branch}",
							file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
							permalink = "/-/blob/{commit}/{file}#L{line_start}-{line_end}",
							commit = "/-/commit/{commit}",
						},
					},
				},
				lazygit = lazygit_opts,
				notifier = { enabled = true },
				terminal = {},
				statuscolumn = {},
				picker = {
					actions = require("trouble.sources.snacks").actions,
					win = {
						input = {
							keys = {
								["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
							},
						},
					},
				},
			})
		end,
		keys = {
			{ "<leader>gl", function() Snacks.lazygit.log() end, desc = "LazyGit Log" },
			{
				"<leader>gb",
				function()
					Snacks.gitbrowse({ what = "file" })
				end,
				mode = { "n", "x" },
				desc = "Git Browse File",
			},
			{ "<leader>lg", function() Snacks.lazygit() end, desc = "LazyGit" },
			{ "<C-_>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
			{ "<C-§>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
			{ "<leader>sf", function() Snacks.picker.smart({ filter = { cwd = true } }) end, desc = "Smart Find Files (CWD)" },
			{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Grep Word or Selection" },
			{ "<leader>sy", function() Snacks.picker.lsp_symbols() end, desc = "File Symbols" },
			{ "<leader>sY", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },
			{ "<C-p>", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume Picker" },
			{ "<leader>sp", function() Snacks.picker.pickers() end, desc = "Pickers" },
			{ "<leader>sf", function() Snacks.picker.grep_word() end, mode = "x", desc = "Grep Selection" },
		},
	},
}
