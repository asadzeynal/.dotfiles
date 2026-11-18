local M = {}

-- Import edits must finish before Conform formats the buffer and the file is saved.
function M.organize_imports(bufnr)
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })[1]
	if not client then
		return
	end

	local function request(method, params)
		local response, err = client:request_sync(method, params, 2000, bufnr)
		if not response or response.err then
			vim.notify("Go imports: " .. vim.inspect(err or (response and response.err)), vim.log.levels.WARN)
			return nil
		end
		return response.result
	end

	local actions = request("textDocument/codeAction", {
		textDocument = { uri = vim.uri_from_bufnr(bufnr) },
		range = { start = { line = 0, character = 0 }, ["end"] = { line = 0, character = 0 } },
		context = { only = { "source.organizeImports" }, diagnostics = {} },
	})
	for _, action in ipairs(actions or {}) do
		if not action.disabled then
			if action.data and not action.edit and client:supports_method("codeAction/resolve") then
				action = request("codeAction/resolve", action)
			end
			if action then
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
				end
				if action.command then
					local command = type(action.command) == "table" and action.command or action
					request("workspace/executeCommand", command)
				end
			end
		end
	end
end

return M
