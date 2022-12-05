local has_npairs, npairs = pcall(require, "nvim-autopairs")
if not has_npairs then
    vim.notify("nvim-autopairs is missing", vim.log.levels.WARN)
    return
end

local Rule = require "nvim-autopairs.rule"

npairs.setup {
    map_c_w = true,
    map_c_h = true,
    enable_check_bracket_line = false,
}

npairs.add_rules {
    Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),
    Rule("( ", " )")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match ".%)" ~= nil
        end)
        :use_key ")",
    Rule("{ ", " }")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match ".%}" ~= nil
        end)
        :use_key "}",
    Rule("[ ", " ]")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match ".%]" ~= nil
        end)
        :use_key "]",
}
