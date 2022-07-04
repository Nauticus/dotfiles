return {
    {
        "hrsh7th/nvim-cmp",
        after = "nvim-autopairs",
        config = function()
            require "config.plugins.configs.cmp"
        end,
        requires = {
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            "andersevenrud/cmp-tmux",
            { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "ray-x/cmp-treesitter",
            { "tzachar/cmp-tabnine", run = "./install.sh" },
            "hrsh7th/cmp-nvim-lua",
            "lukas-reineke/cmp-under-comparator",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require "config.plugins.configs.luasnip"
        end,
    },
}
