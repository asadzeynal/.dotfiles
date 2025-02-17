return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				theme = "wave",
			})

			vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "auto" },
				sections = {
					lualine_c = {
						{
							"filename",
							show_filename_only = false,
							path = 1,
						},
					},
				},
			})
		end,
	},
}
