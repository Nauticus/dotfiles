return {
    "luukvbaal/statuscol.nvim",
    enabled = false,
    opts = {
        separator = "│",
        foldfunc = "builtin",
        setopt = true,
        order = "SFNs",
    },
    config = function(_, opts)
        require("statuscol").setup(opts)
        -- vim.o.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T@v:lua.ScNa@%=%{v:lua.ScLn()}%T"
    end,
}

