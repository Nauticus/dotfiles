local function kanagawa_config()
    local colors = require("kanagawa.colors").setup()

    require("kanagawa").setup {
        undercurl = true,
        transparent = true,
        globalStatus = true,
        dimInactive = false,
        overrides = {
            TelescopeBorder = { fg = colors.fujiGray, bg = "NONE" },
        },
    }
    vim.cmd "colorscheme kanagawa"
end

return {
    "rebelot/kanagawa.nvim",
    config = kanagawa_config,
}
