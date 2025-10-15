return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
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
