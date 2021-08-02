local function project_name()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

require('lualine').setup {
    options = { theme = 'tokyonight' },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'diagnostics', sources = { 'nvim_lsp' } }, { 'diff', colored = false } },
        lualine_y = { 'location', { 'filetype' }, { 'fileformat', icons_enabled = false } },
        lualine_z = {  'ObsessionStatus', { project_name, separator = 'c' } }
    },
    inactive_sections = { lualine_c = { { 'filename',  path = 1 } } }
}
