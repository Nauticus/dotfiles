require('lualine').setup {
    options = { theme = 'tokyonight' },
    extensions = { 'fzf' },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'filetype' }, { 'fileformat', icons_enabled = false } },
        lualine_y = { { 'diagnostics', sources = { 'nvim_lsp' } }, { 'diff', colored = false } },
        lualine_z = { 'progress', 'location' }
    },
    inactive_sections = { lualine_c = { { 'filename', full_path = true } } }
}
