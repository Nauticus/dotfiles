local filename = require "tabby.filename"
local utils = require "tabby.util"

local cwd = function()
    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
end

local tabname = function(tabid)
    return vim.api.nvim_tabpage_get_number(tabid)
end

local function obsession()
    return "  " .. vim.api.nvim_eval [[ObsessionStatus('', '')]] .. " "
end

local active_win_hl = utils.extract_nvim_hl "TabbyWinActive"

local tabline = {
    hl = "TabLineFill",
    layout = "active_wins_at_end",
    head = {},
    active_tab = {
        label = function(tabid)
            return { " " .. tabname(tabid) .. " ", hl = "TabLineActiveTab" }
        end,
    },
    inactive_tab = {
        label = function(tabid)
            return { " " .. tabname(tabid) .. " ", hl = "TabLineInactiveTab" }
        end,
    },
    top_win = {
        label = function(winid)
            return {
                " " .. filename.unique(winid) .. " ",
                hl = { bg = active_win_hl.bg, style = "bold" },
            }
        end,
    },
    win = {
        label = function(winid)
            return { " " .. filename.unique(winid) .. " " }
        end,
    },
    tail = { { cwd, hl = "TabbyCwd" }, { obsession, hl = "ObsessionStatus" } },
}

require("tabby").setup { tabline = tabline }
