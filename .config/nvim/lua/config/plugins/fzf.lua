vim.env['FZF_DEFAULT_OPTS'] = '+m'
vim.env['FZF_DEFAULT_COMMAND'] = 'fd --type f --hidden --follow --exclude .git'

vim.api
    .nvim_set_keymap('n', "<leader><leader>", ":Files <C-R>=expand('%:h')<CR><CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>;", ":Files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "§", ":Buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>hh", ":History<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>rg", ":Rg <C-R>*<CR><CR>", { noremap = true })
