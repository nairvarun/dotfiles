---- bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

---- install plugins
require('packer').startup({function(use)
	----> packer
	use 'wbthomason/packer.nvim'					-- so that packer manages itself

	----> syntax
	use {
		'nvim-treesitter/nvim-treesitter',			-- treesitter
		run = ':TSUpdate'
	}

	----> lsp
	use 'neovim/nvim-lspconfig'						-- easy nvim lsp setup
	-- use 'williamboman/nvim-lsp-installer'		-- to install lsp servers easily

	----> completion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-nvim-lua'

	----> snippets
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'rafamadriz/friendly-snippets'

	----> comments
	-- use 'numToStr/Comment.nvim'

	----> telescope
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	----> git
	use 'lewis6991/gitsigns.nvim'

	----> qol
	use 'jpalardy/vim-slime'						-- slime (like in emacs)
	use {
		'mattn/emmet-vim',							-- emmet (html)
		opt = true,
		ft = {
			'html',
			'markdown',
			'css',
			'javascript',
			'javascriptreact',
			'typescript',
			'typescriptreact',
			'json',
			'svelte'
		},
		config = function () vim.cmd('EmmetInstall') end
	}
	-- use 'tpope/vim-surround'						-- surround (tpope)

	----> colorthemes
	use 'catppuccin/nvim'							-- [colorscheme] catppuccin
	-- use 'folke/tokyonight.nvim'					-- [colorscheme] tokyonight
	-- use 'sainnhe/everforest'						-- [colorscheme] everforest
	-- use 'andreasvc/vim-256noir'					-- [colorscheme] 256noir
	-- use 'arcticicestudio/nord-vim'				-- [colorscheme] nord
	use 'plan9-for-vimspace/acme-colors'			-- [colorscheme] acme

	if packer_bootstrap then
		require('packer').sync()
	  end
end,

---- floating window
config = {
	display = {
		open_fn = require('packer.util').float
	},
	profile = {
		enable = true,
		threshold = 0
	}
}})

---- auto source and packer sync on saving init.lua
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = {"packer.lua"},
	callback =
		function()
			if not pcall(function () vim.cmd("source <afile>") vim.cmd("PackerSync") end) then
				print('could not run :PackerSync')
			end
		end,
	group = vim.api.nvim_create_augroup("packer", { clear = true }),
})

