-- plugins/telescope.lua:
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")
		local builtin = require("telescope.builtin")
		local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

		telescope.setup({
			extensions = {
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob !*test* --iglob !*mock*" }),
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		vim.keymap.set({ "x", "v" }, "<leader>sf", function()
			live_grep_args_shortcuts.grep_visual_selection({ quote = false })
		end)
		telescope.load_extension("live_grep_args")
	end,
}
