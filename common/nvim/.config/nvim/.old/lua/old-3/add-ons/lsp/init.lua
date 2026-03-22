local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify('protected call to lspconfig failed at **/nvim/lua/user/add-ons/lsp/init.lua')
	return
end

require("user/add-ons/lsp/lsp-installer")
require("user/add-ons/lsp/handlers").setup()
