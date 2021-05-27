-- local fn = vim.fn
local gl = require('galaxyline')
local section = gl.section

local one = {
    line = '#2e3440',
    background = '#282c34',
    foreground = '#abb2bf',
    black = '#5c6370',
    red = '#e06c75',
    green = '#98c379',
    yellow = '#e5c07b',
    blue = '0x61afef',
    magenta = '#c678dd',
    cyan = '#56b6c2',
    white = '#abb2bf'
}

-- local buffer_not_empty = function()
--     if fn.empty(fn.expand("%:t")) ~= 1 then
--         return true
--     end
--     return false
-- end

section.left[1] = {
    FirstLine = {
        provider = function()
            return ' '
        end,
        highlight = { one.blue, one.magenta }
    }
}
