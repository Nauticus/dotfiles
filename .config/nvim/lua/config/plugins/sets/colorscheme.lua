local function kanagawa_config()
    local colors = require("kanagawa.colors").setup()

    require("kanagawa").setup {
        undercurl = true,
        transparent = true,
        globalStatus = true,
        dimInactive = false,
        overrides = {
            TelescopeBorder = { fg = colors.fujiGray, bg = "NONE" },
            LeapLabelPrimary = { fg = "#FFFFFF", bg = colors.autumnRed, bold = true },
            WhichKeyFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
        },
    }
    vim.cmd "colorscheme kanagawa"
end

local function themer_config()
    require("themer").setup {
        colorscheme = "nord",
        transparent = true,
    }
end

local function onedark_config()
    require("onedark").setup { transparent = true }
end

local function gruvbox_config()
    vim.g.gruvbox_transparent_bg = true
    vim.cmd [[colorscheme gruvbox]]
end

local function nord_config()
    vim.g.nord_disable_background = true
    vim.cmd [[colorscheme nord]]
end

local function github_dark_config()
    vim.cmd [[colorscheme github_dark]]
    vim.api.nvim_set_hl(0, "Normal", { bg = nil })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = nil })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = nil })
end

return {
    {
        "rebelot/kanagawa.nvim",
        disable = false,
        config = kanagawa_config,
    },
    {
        "themercorp/themer.lua",
        disable = true,
        config = themer_config,
    },
    {
        "ful1e5/onedark.nvim",
        disable = true,
        config = onedark_config,
    },
    {
        "ellisonleao/gruvbox.nvim",
        disable = true,
        config = gruvbox_config,
    },
    {
        "shaunsingh/nord.nvim",
        disable = true,
        config = nord_config,
    },
    {
        "lewis6991/github_dark.nvim",
        disable = true,
        config = github_dark_config,
    },
}
