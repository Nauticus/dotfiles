local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

local rec_ls

rec_ls = function()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t { "" },
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t { "", "\t\\item " }, i(1), d(2, rec_ls, {}) }),
        }),
    })
end

local require_var = function(args, _)
    local text = args[1][1] or ""
    local split = vim.split(text, ".", { plain = true })

    local options = {}
    for len = 0, #split - 1 do
        table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
    end

    if #options == 1 then
        return sn(nil, {
            options[1],
        })
    end

    return sn(nil, {
        c(1, options),
    })
end

local get_package_from_clipboard = function()
    -- Get the author and URL in the clipboard and auto populate the author and project
    local default = s("", { i(1, "author"), t "/", i(2, "plugin") })
    ---@diagnostic disable-next-line: missing-parameter
    local clip = vim.fn.getreg "*"
    if not vim.startswith(clip, "https://github.com/") then
        return default
    end
    local parts = vim.split(clip, "/")
    if #parts < 2 then
        return default
    end
    local author, project = parts[4], parts[5]
    return s("", { t(author .. "/" .. project) })
end

local get_rhs_from_clipboard = function()
---@diagnostic disable-next-line: missing-parameter
    local ok, clip = pcall(vim.fn.getreg "*")

    clip = ok and clip or ""

    return sn(nil, {
        t(clip),
    })
end

return {
    s(
        { trig = "req", name = "local require" },
        fmt([[local {} = require("{}")]], {
            d(2, require_var, { 1 }),
            i(1),
        })
    ),
    s(
        { trig = "local", name = "local variable" },
        fmt("local {} = {}", {
            i(1),
            i(2),
        })
    ),
    s(
        { trig = "tblext", name = "vim extend table" },
        fmt("vim.tbl_extend({}, {}, {})", {
            c(1, {
                t '"force"',
                t '"error"',
                t '"keep"',
            }),
            i(2, "tbl1"),
            i(3, "tbl2"),
        })
    ),
    s(
        { trig = "use", name = "packer use" },
        fmt([[{}{{"{}"{}}}]], {
            c(1, {
                t "",
                t "use ",
            }),
            d(2, get_package_from_clipboard),
            c(3, {
                fmt([[, config = {}]], i(1)),
                t "",
            }),
        })
    ),
    s(
        "styluaignore",
        fmt(
            "-- stylua: ignore{}",
            c(1, {
                t "",
                t " start",
                t " end",
            })
        )
    ),
    s("ls", {
        t { "\\begin{itemize}", "\t\\item " },
        i(1),
        d(2, rec_ls, {}),
        t { "", "\\end{itemize}" },
        i(0),
    }),
    s(
        { trig = "vim.keymap.set", name = "set keymap" },
        fmt([[{}keymap.set({}, {}, {}, {})]], {
            c(1, {
                t "",
                t "vim.",
            }),
            c(2, {
                fmt('"{}"', r(1, "mode")),
                fmt('{{"{}"}}', r(1, "mode")),
            }),
            c(3, {
                fmt('"{}"', r(1, "lhs")),
                fmt('"<leader>{}"', r(1, "lhs")),
                fmt('"<localleader>{}"', r(1, "lhs")),
            }),
            c(4, {
                t "",
                i(nil),
                d(nil, get_rhs_from_clipboard),
            }),
            c(5, {
                i(1, "opts"),
                fmt("{{{}}}", i(1)),
                fmt('{{ desc = "{}" }}', i(1)),
            }),
        }),
        {
            stored = {
                mode = i(1, "n"),
                lhs = i(1),
            },
        }
    ),
}
