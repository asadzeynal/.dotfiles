return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			"folke/trouble.nvim",
		},
		opts = function(_, opts)
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
				lazygit = {},
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
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<C-p>", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume Picker" },
			{ "<leader>sp", function() Snacks.picker.pickers() end, desc = "Pickers" },
			{ "<leader>sf", function() Snacks.picker.grep_word() end, mode = "x", desc = "Grep Selection" },
		},
	},
}
