local g = vim.g
local cmd = vim.cmd
_G.Overrides = {}

local hl = function(group, options)
    local bg = options.bg == nil and "" or "guibg=" .. options.bg
    local fg = options.fg == nil and "" or "guifg=" .. options.fg
    local gui = options.gui == nil and "" or "gui=" .. options.gui

    cmd(string.format("hi %s %s %s %s", group, bg, fg, gui))

end

-- tokyonight
g.tokyonight_style = "night"
g.tokyonight_transparent = false
g.tokyonight_sidebars = { "qf", "packer", "NvimTree", "DiffviewFiles" }
g.tokyonight_dark_sidebar = true
g.tokyonight_dark_float = true
g.tokyonight_lualine_bold = false
g.markdown_folding = 1
g.tokyonight_hide_inactive_statusline = false
g.tokyonight_italic_functions = true

Overrides.tokyonight = function()
    local colors = require("tokyonight.colors").setup(require("tokyonight.config"))
    local utils = require("tokyonight.util")

    hl("NvimTreeOpenedFolderName", { fg = utils.lighten(colors.teal, 0.8), gui = "bold" })
    hl("NvimTreeFolderName", { fg = colors.blue })
    hl("LspSignatureActiveParameter", { fg = colors.blue })
    hl("SpecialKey", { fg = colors.green })
    hl("NonText", { fg = utils.lighten(colors.bg, 0.92) })
    hl("IndentBlanklineIndent1", { bg = utils.darken(colors.bg, 0), gui = "nocombine" })
    hl("IndentBlanklineIndent2", { bg = utils.lighten(colors.bg, 0.97), gui = "nocombine" })
    hl("LualineObsession", { fg = colors.red, bg = utils.brighten(colors.fg_gutter, 0.1) })
end

-- onedark
Overrides.onedark = function()
    local colors = require("onedark.colors").setup(require("onedark.config"))
    local utils = require("onedark.util")

    hl("NvimTreeOpenedFolderName", { fg = utils.lighten(colors.red, 0.8), gui = "bold" })
    hl("NvimTreeFolderName", { fg = colors.blue, bg = colors.red })
    hl("ObsessionStatus", { fg = colors.red, bg = colors.bg })
    hl("Sneak", { bg = colors.black, fg = colors.fg })
    hl("SneakLabel", { bg = colors.black, fg = colors.red, gui = "bold" })
    hl("SneakLabelMask", { bg = colors.black, fg = colors.black })
    hl("TabbyWinActive", { bg = colors.bg_visual })
end

-- Overrides.github = function ()
--     hl("TabbyWinActive", { bg = })
-- end

-- -- nord
-- vim.g.nord_contrast = true
-- vim.g.nord_borders = true
-- vim.g.nord_disable_background = false
-- vim.g.nord_italic = false

-- -- nightfox
-- g.nightfox_style = "nightfox"
-- g.nightfox_italic_keywords = true
-- g.nightfox_italic_functions = true

-- -- sonokai
-- g.sonokai_style = 'default'
-- g.sonokai_enable_italic = 1
-- g.sonokai_disable_italic_comment = 1

cmd [[
    augroup OverideColorscheme
        au!
        au ColorScheme tokyonight call v:lua.Overrides.tokyonight()
        au ColorScheme onedark call v:lua.Overrides.onedark()
    augroup END
]]
