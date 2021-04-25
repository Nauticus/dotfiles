local npairs = require('nvim-autopairs')
local fn = vim.fn
_G.utils = {}

_G.utils.check_backspace = function()
    local curr_col = fn.col(".")
    local is_first_col = fn.col(".") - 1 == 0
    local prev_char = fn.getline("."):sub(curr_col - 1, curr_col - 1)

    if is_first_col or prev_char:match("%s") then
        return true
    else
        return false
    end
end

_G.utils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

_G.utils.echo_highlight = function()
    local hi = fn.synIDattr(fn.synID(fn.line('.'), fn.col('.'), 1), 'name')
    local trans = fn.synIDattr(fn.synID(fn.line("."), fn.col("."), 0), "name")
    local lo = fn.synIDattr(fn.synIDtrans(fn.synID(fn.line("."), fn.col("."), 1)), "name")

    print(string.format('hi<%s> trans<%s> lo<%s>', hi, trans, lo))
end

