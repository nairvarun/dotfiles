--TODO{{{
------------------------------------------------------------------------------------------------------
--	- try and get comfortable with packer and use its more advanced features
--
--
--
--	refer
--		- (https://bryankegley.me/posts/nvim-getting-started/)
--		- (https://github.com/wbthomason/dotfiles/tree/linux/neovim/.config/nvim)
--
------------------------------------------------------------------------------------------------------
--}}}

local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end


return require('packer').startup({function()
	use 'wbthomason/packer.nvim'	-- Packer can manage itself
	use 'neovim/nvim-lspconfig'
	use "hrsh7th/nvim-cmp"
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
end,
-- the following config makes sure that the packer updates are dispalyed in a floating window
config = {
	display = {
		open_fn = require('packer.util').float,
	}
}})
