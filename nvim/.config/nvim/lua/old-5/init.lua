----------------------------- settings 

vim.cmd[[
    syntax off
    filetype plugin indent on
]]

-- :help options
vim.opt.mouse 			= 'a'               -- enable use of mouse
vim.opt.clipboard 		= 'unnamedplus'     -- share system clipboard
vim.opt.tabstop 		= 4                 -- value of `\t`
vim.opt.shiftwidth 		= 4                 -- value of 1 level of indentation (eg: `>>` in vim)
vim.opt.expandtab 		= true              -- convert `\t` into spaces
vim.opt.number 			= true              -- show linenumber
vim.opt.relativenumber 	= true              -- show line number relative to current line
vim.opt.hlsearch 		= true              -- highlight words that match during search
vim.opt.ignorecase 		= true              -- case insensitive search
vim.opt.smartcase 		= true              -- case sensitive search only of uppercase is used
vim.opt.splitbelow 		= true              -- always open vertical split on the bottom half
vim.opt.splitright 		= true              -- always open horizontal split on the right half
vim.opt.scrolloff 		= 5                 -- start scrolling when the cursor is on the 5th last line
vim.opt.sidescrolloff 	= 5                 -- start scrolling horizontallu when the cursor is on the 5th last character on a line
vim.opt.showmatch 		= true              -- indicate matching bracket
vim.opt.visualbell 		= true              -- visual alert
vim.opt.termguicolors 	= true              -- gui colours in the terminal is supported
vim.opt.wrap 			= false             -- disable word wrap
vim.opt.signcolumn 		= 'number'          -- replaces line number with lsp err symbol

vim.opt.path:append('**')                   -- fuzzy file finding (`:find`)
vim.opt.completeopt:remove('preview')       -- disable scratch buffer for lsp omnicompletion


----------------------------- filetype specific settings

function webdevSettings()
    vim.opt_local.tabstop    = 2            -- value of `\t`
    vim.opt_local.shiftwidth = 2            -- value of 1 level of indentation (eg: `>>` in vim)
end

function lispSettings()
    vim.opt_local.lisp = true               -- lisp mode
end

-- list filetypes
    -- https://vi.stackexchange.com/questions/5780/list-known-filetypes
    -- all
        -- :echo getcompletion('', 'filetype')
    -- starting with letter c
        -- :echo getcompletion('c', 'filetype')
-- use `unsilent` for echoing messages in autocmds because `:set shortmess+=F` by default in neovim
    -- https://github.com/neovim/neovim/wiki/FAQ#calling-inputlist-echomsg--in-filetype-plugins-and-autocmd-does-not-work
vim.cmd[[
    augroup filetype_cmds
        autocmd!
        " webdev
        au Filetype html,markdown,css,javascript,javascriptreact,typescript,typescriptreact,json,svelte lua webdevSettings()
        au Filetype html,markdown,css,javascript,javascriptreact,typescript,typescriptreact,json,svelte EmmetInstall
        " lisp
        au Filetype lisp,scheme,clojure lua lispSettings()
        " non-treesitter
        au Filetype conf,tmux syntax on
    augroup end
]]


----------------------------- keymaps

-- leader ==> alt
-- if ␛ is set to <Nop> Alt+{x} wont sent the escape signal in any terminal
-- vim.api.nvim_set_keymap('', '␛', '<Nop>', {noremap = true})
vim.g.mapleader = ''	    -- `^[`(alt) typed by `ctrl+v alt+esc`

-- -- esc
-- vim.api.nvim_set_keymap('!', '<leader>i', '<esc>', {noremap=true})

-- block selection ==> v
-- `v` toggles between block visual and then visual
vim.api.nvim_set_keymap('n', 'v', '<C-v>', {noremap=true})

-- $
vim.api.nvim_set_keymap('n', '<leader>e', '$', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>e', '$', {noremap=true})
vim.api.nvim_set_keymap('o', '<leader>e', '$', {noremap=true})

-- %
vim.api.nvim_set_keymap('n', '<leader>p', '%', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>p', '%', {noremap=true})

-- next, prev, path completion, omnicomplition
vim.api.nvim_set_keymap('i', '<leader>j', '<C-n>', {noremap=true})
vim.api.nvim_set_keymap('i', '<leader>k', '<C-p>', {noremap=true})
vim.api.nvim_set_keymap('i', '<leader>n', '<C-x><C-o>', {noremap=true})
vim.api.nvim_set_keymap('i', '<leader>m', '<C-x><C-f>', {noremap=true})

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>bn<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>bp<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<Tab>', ':b ', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<S-Tab>', ':find ', {noremap=true})

-- tab navigation
vim.api.nvim_set_keymap('n', '<leader>l', 'gt', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>h', 'gT', {noremap=true})

-- split navigation
-- vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap=true})

-- toggle split focus
local isFocused = false
function toggleFocus()
    if (isFocused) then
        vim.api.nvim_exec([[call feedkeys("\<C-w>=")]], true)
    else
        vim.api.nvim_exec([[call feedkeys("\<C-w>|\<C-w>_")]], true)
    end
    isFocused = not isFocused
end
vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>lua toggleFocus()<CR>', {noremap=true, silent=true})

-- remove highlights
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>noh<CR>', {noremap=true})

-- Lexplore
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Lexplore 20<CR>', {noremap=true})


----------------------------- packer

-- bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
-- install plugins
require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'                    -- so that packer manages itself
    use 'neovim/nvim-lspconfig'                     -- easy nvim lsp setup
    use 'mattn/emmet-vim'                           -- emmet (html)
    use {
        'nvim-treesitter/nvim-treesitter',          -- treesitter
        run = ':TSUpdate'
    }
    use 'jpalardy/vim-slime'                        -- slime like in emacs

    -- colorschemes
    use 'catppuccin/nvim'
    -- use 'folke/tokyonight.nvim'
    -- use 'sainnhe/everforest'
    use 'andreasvc/vim-256noir'
    -- use 'arcticicestudio/nord-vim'

    if packer_bootstrap then
        require('packer').sync()
      end
end,
-- so that packer uses a floating window
config = {
    display = {
        open_fn = require('packer.util').float
    },
    profile = {
        enable = true,
        threshold = 0
    }
}})

-- auto source and packer sync on saving init.lua
vim.md[[
    augroup source_init
        autocmd!
        autocmd BufWritePost ~/.config/nvim/init.lua source ~/.config/nvim/init.lua
        autocmd BufWritePost ~/.config/nvim/init.lua PackerSync
    augroup end
]]



----------------------------- colorscheme

vim.cmd[[
    colorscheme catppuccin
    " let g:tokyonight_style = "storm"
    " let g:tokyonight_style = "night"
    " colorscheme tokyonight
]]


----------------------------- lsp 

-- https://github.com/neovim/nvim-lspconfig

-- -- Mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Enable (broadcasting) snippet capability for completion
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- 'eslint' is not included for now because it is duplicating tsserver features
-- 'html', 'cssls' servers are not included now cos they need a snippet engine to be useful
local servers = { 'pyright' , 'clangd', 'tsserver', 'julials' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end
-- require'lspconfig'.dartls.setup {
--     cmd = { "dart", "/home/nv/.local/devel/flutter-sdk-04_22/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
--     on_attach = on_attach,
-- }



----------------------------- treesitter

require'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = {},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}


----------------------------- emmet

-- remap emmet leader 
vim.g.user_emmet_leader_key='<leader>e'

-- olny work in normal mode
-- vim.g.user_emmet_mode='n'

-- only work for html, css, js-react, ts-react
    -- to get lsit of all file types --> :echo getcompletion('', 'filetype')
    -- https://vi.stackexchange.com/questions/5780/list-known-filetypes
vim.g.user_emmet_install_global = 0
-- autocmd that makes emmet run on specific filetypes is defined above


----------------------------- vim-slime

-- config
vim.g.slime_target='tmux'
vim.g.slime_default_config={socket_name = "default", target_pane = "{last}"}

-- keymaps
vim.api.nvim_set_keymap('n', '<leader>s', 'V<Plug>SlimeRegionSend', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>S', 'V<Plug>SlimeParagraphSend', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>s', 'V<Plug>SlimeRegionSend', {noremap=true})
vim.api.nvim_set_keymap('x', '<leader>S', '<Plug>SlimeRegionSend', {noremap=true})

