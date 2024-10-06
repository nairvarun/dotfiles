local M = {}

M.setup = function()
	-- :h diagnostic.txt
	vim.diagnostic.config({
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
		},
		virtual_text = false,
		update_in_insert = true,
		severity_sort = true,
	})

	-- gives non diagnostic floating windows rounded border
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		focusable = false,
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fD", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fc", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fj", '<cmd>lua vim.diagnostic.goto_next({float = {border = "rounded"}})<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fk", '<cmd>lua vim.diagnostic.goto_prev({float = {border = "rounded"}})<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n",	"fl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "fq", "<cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "F", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true})
	vim.cmd[[
	augroup settings
		autocmd!
		autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
		autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
	augroup end
	]]
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end
M.capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
