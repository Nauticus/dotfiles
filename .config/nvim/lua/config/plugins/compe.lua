local remap = vim.api.nvim_set_keymap

remap('i', '<C-y>', 'compe#confirm(\'<CR>\')', { noremap = true, silent = true, expr = true })
