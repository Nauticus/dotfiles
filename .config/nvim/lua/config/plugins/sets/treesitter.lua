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
        },
    },
    {
        "windwp/nvim-autopairs",
        disable = false,
    },
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { ["method"] = "popup" }
        end,
    },
}
