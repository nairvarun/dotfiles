-- ref
	-- https://github.com/wbthomason/packer.nvim
	-- https://dev.to/ritikadas/using-neovim-as-an-effortless-way-to-edit-code-installation-and-setup-guide-for-windows-10-5dhc
	
    require('packer').startup(function()
        use 'wbthomason/packer.nvim'
        use 'github/copilot.vim'
        use 'morhetz/gruvbox'
        use 'neovim/nvim-lspconfig'
        --use 'ms-jpq/coq_nvim'
        use {'neoclide/coc.nvim', branch = 'release'}
    end)
    
    --require'lspconfig'.pyright.setup{}
    
    vim.cmd [[
        colorscheme gruvbox
        syntax on
        filetype plugin indent on
    ]]
    
    vim.api.nvim_set_keymap('n', '<A-v>', '<c-v>', {})
    
    local set = vim.opt
    
    set.mouse = 'a'
    set.relativenumber = true
    set.visualbell = true
    set.clipboard = 'unnamedplus'
    set.hlsearch = true
    set.ruler = true
    set.cursorline = true
    set.cursorcolumn = false
    set.foldmethod = 'marker'
    set.wrap = false
    set.tabstop = 4
    set.shiftwidth = 4
    
    