-- installs packer if not already installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd [[packadd packer.nvim]]
end


-- calls require("packer"). if it doesnt work, it'll notify and not throw a big error. if it works, it'll return require("packer") as packer.
local ok, packer = pcall(require, "packer")
if not ok then
	vim.notify('protected call failed in **/nvim/lua/user/add-ons/plugins.lua')
end


return packer.startup({function(use)
	use 'wbthomason/packer.nvim' -- so that packer manages itself
	use {
		'github/copilot.vim',
		opt = true
	}
	use 'nvim-lua/popup.nvim'		-- required by other plugins
	use 'nvim-lua/plenary.nvim'		-- required by other plugins
	use {
		'wfxr/minimap.vim',			-- requires 'https://github.com/wfxr/code-minimap' (cargo install --locked code-minimap)
		opt = true,
		cmd = 'MinimapToggle',
	}
	use {
		'iamcco/markdown-preview.nvim',
		run = 'cd app && yarn install',
		opt = true,
		ft = 'markdown',
	}
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/cmp-nvim-lua"
	use "hrsh7th/cmp-nvim-lsp"

	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"

	use "neovim/nvim-lspconfig"
	use "williamboman/nvim-lsp-installer"

	use 'folke/tokyonight.nvim'
	-- use 'morhetz/gruvbox'
	-- use 'lifepillar/vim-solarized8'
	-- use 'arcticicestudio/nord-vim'
	-- use 'sainnhe/everforest'}
	-- use 'joshdick/onedark.vim'
	-- use 'plan9-for-vimspace/acme-colors'
	-- use 'AlessandroYorba/Alduin'
	-- use 'glepnir/oceanic-material'

	if packer_bootstrap then
		require('packer').sync()
	end
end,
config = {
	display = {
		open_fn = require('packer.util').float
	},
	profile = {
		enable = true,
		threshold = 0
	}
}})

