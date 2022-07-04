return {
    {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/nvim-lsp-installer",
            "jose-elias-alvarez/nvim-lsp-ts-utils",
            "b0o/schemastore.nvim",
            "folke/lua-dev.nvim",
            { "kosayoda/nvim-lightbulb", config = function ()
                require("nvim-lightbulb").setup {}
            end},
        },
        config = function()
            require "config.plugins.configs.lspconfig"
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        requires = "PlatyPew/format-installer.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "config.plugins.configs.null-ls"
        end,
    },
    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        after = "nvim-lspconfig",
        config = function()
            require("trouble").setup {}
        end,
    },
    {
        "j-hui/fidget.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("fidget").setup {}
        end,
    },
}
