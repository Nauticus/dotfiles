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
            NormalFloat = { bg = "NONE" },

            ScrollbarHandle = { bg = colors.sumiInk3 },
            ScrollbarCursorHandle = { bg = colors.sumiInk3, fg = colors.sumiInk4 },
            ScrollbarCursor = { fg = colors.sumiInk4 },
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

local function catppuccin_config()
    require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        term_colors = false,
        color_overrides = {},
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            notify = true,
            mini = false,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    }
    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
end

-- SETUP
catppuccin_config()
