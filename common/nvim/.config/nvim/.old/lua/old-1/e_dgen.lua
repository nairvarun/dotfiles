function _G.toggleDgen()
        print('-- DEGEN --')
end

vim.api.nvim_set_keymap('n', '<C-LeftMouse>', ':lua toggleDgen()<CR>', {})
