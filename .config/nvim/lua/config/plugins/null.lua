return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
        "jayp0521/mason-null-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        require("mason-null-ls").setup({
            ensure_installed = { "stylua", "prettier" },
        })

        require("mason-null-ls").setup_handlers({
            function(source_name, methods)
                require("mason-null-ls.automatic_setup")(source_name, methods)
            end,
            -- stylua = function(source_name, methods)
            --     null_ls.register(null_ls.builtins.formatting.stylua)
            -- end,
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.code_actions.gitsigns,
            },
            debug = true,
        })
    end,
}
