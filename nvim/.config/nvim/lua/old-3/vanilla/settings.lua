--region
vim.cmd[[
	syntax on
	filetype plugin indent on
]]
--endregion

--region :set opts
-- :help options
vim.opt.mouse 			= 'a'
vim.opt.clipboard 		= 'unnamedplus'
vim.opt.shiftwidth 		= 4
vim.opt.tabstop 		= 4
vim.opt.foldmethod		= 'marker'
vim.opt.foldmarker		= 'region,endregion'
vim.opt.number 			= true
vim.opt.relativenumber 	= true
vim.opt.cursorline 		= true
vim.opt.hlsearch 		= true
vim.opt.ignorecase 		= true
vim.opt.smartcase 		= true
vim.opt.splitbelow 		= true
vim.opt.splitright 		= true
vim.opt.timeoutlen 		= 150
vim.opt.undofile 		= true
-- vim.opt.scrolloff 		= 5
-- vim.opt.sidescrolloff 	= 5
vim.opt.visualbell 		= true
vim.opt.termguicolors	= true
vim.opt.wrap			= false
vim.opt.showtabline		= 1
vim.opt.signcolumn 		= 'number'
--endregion

--region autocmds
-- so that i dont have to source or run packersync after changes to config
vim.cmd[[
	augroup settings
		autocmd!
		autocmd BufWritePost */nvim/**.lua source <afile> 
		autocmd BufWritePost */nvim/*plugins.lua PackerSync 
	augroup end
]]
--endregion
