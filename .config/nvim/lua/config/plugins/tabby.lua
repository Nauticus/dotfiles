local filename = require "tabby.filename"
local utils = require "tabby.util"

local cwd = function()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
end

local tabname = function(tabid)
    return vim.api.nvim_tabpage_get_number(tabid)
end

local function obsession()
    return "  " .. vim.api.nvim_eval [[ObsessionStatus('', '')]] .. "  "
end

local tabline_hl = utils.extract_nvim_hl "TabLine"
local tabline_sel_hl = utils.extract_nvim_hl "TabLineSel"

local tabline = {
    hl = "TabLineFill",
    layout = "active_wins_at_end",
    head = {},
    active_tab = {
        label = function(tabid)
            return { " " .. tabname(tabid) .. " ", hl = { bg = tabline_sel_hl.bg } }
        end,
    },
    inactive_tab = {
        label = function(tabid)
            return { " " .. tabname(tabid) .. " ", hl = { fg = tabline_sel_hl.fg } }
        end,
    },
    top_win = {
        label = function(winid)
            return {
                " " .. filename.unique(winid) .. " ",
                hl = { bg = tabline_hl.bg, style = "bold" },
            }
        end,
    },
    win = {
        label = function(winid)
            return { " " .. filename.unique(winid) .. " " }
        end,
    },
    tail = {
        { obsession, hl = { fg = tabline_sel_hl.fg } },
        { cwd, hl = { bg = tabline_sel_hl.bg } },
    },
}

require("tabby").setup { tabline = tabline }
