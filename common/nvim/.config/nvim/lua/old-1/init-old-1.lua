--notes{{{

-- todo: make (custom) -- DEGEN -- mode
-- 	- wasd to move
-- 	- mouse gestures
--
-- make a custom popup menu? https://vi.stackexchange.com/questions/580/how-to-define-a-custom-popup-menu-in-vimrc
--
-- enable spell checker? (hi! spellbad)
--
-- use native lsp
--
-- figure out lazy loading later
--	- (https://bryankegley.me/posts/nvim-getting-started/)
--	- (https://github.com/wbthomason/packer.nvim#quickstart)
--	- (https://jdhao.github.io/2021/07/11/from_vim_plug_to_packer/)
--	- (https://github.com/wbthomason/dotfiles/tree/linux/neovim/.config/nvim)
--	- (https://www.youtube.com/watch?v=BoDU6QOmEOY)
--
-- actually useful links
--  - https://github.com/neovim/nvim-lspconfig
--  - https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

-- }}}

-- require{{{

require('old-1/vimcmd')
require('old-1/vimopt')
require('old-1/keymaps')
require('old-1/plugins')
require('old-1/cmp_config')

require'lspconfig'.ccls.setup{}

---}}}
