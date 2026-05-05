return {
	"nvim-treesitter/nvim-treesitter",
	-- build = function()
	-- 	require("nvim-treesitter.install").update({ with_sync = true })()
	-- end,
	config = function()
		require("nvim-treesitter").install({
			"go",
			"gomod",
			"sql",
			"yaml",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"regex",
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				-- Enable treesitter highlighting and disable regex syntax
				pcall(vim.treesitter.start)
				-- Enable treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require("nvim-treesitter").setup({
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)

			-- Install parsers synchronously (only applied to `ensure_installed`)
			-- sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			-- auto_install = true,

			-- highlight = {
			-- 	enable = true,
			--
			-- 	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- 	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- 	-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- 	-- Instead of true it can also be a list of languages
			-- 	additional_vim_regex_highlighting = false,
			-- },
			--
			-- add these to satisfy the TSConfig type:
			-- modules = {}, -- internal; safe to leave empty
			-- ignore_install = {}, -- list parsers to skip, keep empty if none
		})
	end,
}
