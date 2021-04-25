require('lualine').setup {
    options = { theme = 'gruvbox' },
    extensions = { 'fzf' },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', full_path = true } },
        lualine_x = { { 'diagnostics', sources = { 'nvim_lsp' } }, { 'diff', colored = false } },
        lualine_y = { { 'filetype', separator = '*' }, 'fileformat' },
        lualine_z = { 'progress', 'location' }
    },
    inactive_sections = { lualine_c = { { 'filename', full_path = true } } }
}
