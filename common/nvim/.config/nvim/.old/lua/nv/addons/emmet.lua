---- remap emmet leader 
vim.g.user_emmet_leader_key='<leader>e'

---- olny work in normal mode
-- vim.g.user_emmet_mode='n'

---- only work for relevant filetypes
	-- to get list of all file types --> :echo getcompletion('', 'filetype')
	-- https://vi.stackexchange.com/questions/5780/list-known-filetypes
vim.g.user_emmet_install_global = 0

vim.api.nvim_create_autocmd("Filetype", {
	group = vim.api.nvim_create_augroup("emmet", { clear = true }),
	pattern = {
		"html",
		"markdown",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"svelte",
	},
	callback = 
		function()
			if not pcall(function () vim.cmd('EmmetInstall') end) then
				print(':EmmetInstall not run by autocmd')
			end 
		end,
})

