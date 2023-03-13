return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "auto",
            disabled_filetypes = { "NvimTree", "DiffviewFiles", "harpoon", "TelescopePrompt" },
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = { { "mode", icons_enabled = true } },
            lualine_b = {
                { "filetype", icon_only = true },
                { "filename", path = 1, file_status = true, shorting_target = 50 },
            },
            lualine_c = {},
            lualine_x = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                },
            },
            lualine_y = {
                {
                    "diff",
                    symbols = { added = "  ", modified = " 柳", removed = "  " },
                    colored = true,
                    padding = { left = 0, right = 1 },
                },
                {
                    "progress",
                },
                {
                    "location",
                },
            },
            lualine_z = { "branch" },
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
    },
}
