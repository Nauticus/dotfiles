return {
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/playground",
            "nvim-treesitter/completion-treesitter",
            "windwp/nvim-ts-autotag",
            {
                "danymat/neogen",
                config = function()
                    require("neogen").setup {
                        enabled = true,
                        snippet_engine = "luasnip",
                        languages = {
                            lua = {
                                template = {
                                    annotation_convention = "emmylua",
                                },
                            },
                        },
                    }
                end,
            },
        },
        config = function()
            require "config.plugins.configs.treesitter"
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require "config.plugins.configs.autopairs"
        end,
    },
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { ["method"] = "popup" }
        end,
    },
}
