local remap = vim.api.nvim_set_keymap

require('compe').setup {
    enabled = true,
    documentation = true,
    debug = true,
    source = { path = true, buffer = true, nvim_lsp = true, nvim_lua = true, ultisnips = true }
}

remap('i', '<C-y>', 'compe#confirm(\'<CR>\')', { noremap = true, silent = true, expr = true })
