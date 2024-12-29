return {
    "williamboman/mason.nvim",
	config = function()
		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = {'lua_ls', 'gopls', 'rust_analyzer'},
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
			},
		})
	end
}
