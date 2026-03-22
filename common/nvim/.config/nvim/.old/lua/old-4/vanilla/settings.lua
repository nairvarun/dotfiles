vim.cmd[[
	syntax on
	filetype plugin indent on
]]

-- :help options
vim.opt.mouse = 'a'
vim.opt.path:append('**')		-- fuzzy file finding
vim.opt.clipboard = 'unnamedplus'
vim.opt.shiftwidth = 4
vim.opt.tabstop	= 4
vim.opt.expandtab = true
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.visualbell = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.signcolumn = 'number'		-- replaces line number with lsp err symbol
vim.opt.completeopt:remove('preview')		-- disable scratch buffer for lsp opmnicompletion

-- -- so that i dont have to source or run packersync after changes to config
-- vim.cmd[[
-- 	augroup settings
-- 		autocmd!
-- 		autocmd BufWritePost */nvim/**.lua source <afile> 
-- 		autocmd BufWritePost */nvim/*plugins.lua PackerSync 
-- 	augroup end
-- ]]

