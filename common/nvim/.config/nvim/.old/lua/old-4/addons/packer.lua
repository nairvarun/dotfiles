-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup({function(use)
	use 'wbthomason/packer.nvim' -- so that packer manages itself
	use 'neovim/nvim-lspconfig'
	use 'mattn/emmet-vim'
    -- colorschemes
	use 'folke/tokyonight.nvim'
	use 'sainnhe/everforest'
	use 'andreasvc/vim-256noir'
	use 'shaeinst/roshnivim-cs'
	use 'catppuccin/nvim'

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

