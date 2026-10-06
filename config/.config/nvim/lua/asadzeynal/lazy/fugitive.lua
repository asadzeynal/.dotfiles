return {
	"tpope/vim-fugitive",
	branch = "master",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<CR>")
	end,
}
