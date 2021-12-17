local wk = require "which-key"

local g = vim.g

g["sneak#label"] = 1
g["sneak#use_ic_scs"] = 1
g["sneak#prompt"] = "  "

wk.register({
    f = { "<Plug>Sneak_f" },
    F = { "<Plug>Sneak_F" },
    t = { "<Plug>Sneak_t" },
    T = { "<Plug>Sneak_T" },
}, { mode = "n", noremap = false })

wk.register({
    f = { "<Plug>Sneak_f" },
    F = { "<Plug>Sneak_F" },
    t = { "<Plug>Sneak_t" },
    T = { "<Plug>Sneak_T" },
}, { mode = "x", noremap = false })

wk.register({
    f = { "<Plug>Sneak_f" },
    F = { "<Plug>Sneak_F" },
    t = { "<Plug>Sneak_t" },
    T = { "<Plug>Sneak_T" },
}, { mode = "o", noremap = false })
