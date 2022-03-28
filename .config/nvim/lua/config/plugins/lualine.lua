require("lualine").setup {
    options = {
        theme = "kanagawa",
        disabled_filetypes = { "NvimTree", "DiffviewFiles" },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { { "mode", icons_enabled = true } },
        lualine_b = {},
        lualine_c = {
            { "filetype", icon_only = true },
            { "filename", path = 1, file_status = true, shorting_target = 50 },
        },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
        },
        lualine_y = {
            { "branch", icon = "" },
            {
                "diff",
                symbols = { added = "  ", modified = " 柳", removed = "  " },
                colored = true,
                padding = { left = 0, right = 1 },
            },
        },
        lualine_z = { { "fileformat", icons_enabled = false } },
    },
    extensions = { "quickfix", "fugitive" },
    inactive_sections = {
        lualine_a = { { "filetype", icon_only = true } },
        lualine_b = { { "filename", path = 1 } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}
