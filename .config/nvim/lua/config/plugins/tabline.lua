require'tabline'.setup {
    -- Defaults configuration options
    enable = true,
    options = {
        -- If lualine is installed tabline will use separators configured in lualine by default.
        -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        show_filename_only = true
    }
}
vim.cmd [[
  set guioptions-=e " Use showtabline in gui vim
  set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]
