local has_lualine, lualine = pcall(require, "lualine")
if not has_lualine then
    vim.notify("lualine is missing", vim.log.levels.WARN)
    return
end

local has_nvim_web_devicons, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if has_nvim_web_devicons then
    nvim_web_devicons.set_icon {
        lir = {
            icon = "",
            color = "",
            cterm_color = "65",
            name = "Lir",
        },
    }
end

lualine.setup {
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
                "progress"
            },
            {
                "location"
            }
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
}
