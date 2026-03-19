-- remap emmet leader 
vim.g.user_emmet_leader_key='<leader>e'

-- olny work in normal mode
-- vim.g.user_emmet_mode='n'

-- only work for html, css, js-react, ts-react
    -- to get lsit of all file types --> :echo getcompletion('', 'filetype')
    -- https://vi.stackexchange.com/questions/5780/list-known-filetypes
vim.g.user_emmet_install_global = 0
vim.cmd[[
    augroup emmet
        autocmd!
        autocmd FileType html,css,javascriptreact,typescriptreact EmmetInstall
    augroup end
]]

