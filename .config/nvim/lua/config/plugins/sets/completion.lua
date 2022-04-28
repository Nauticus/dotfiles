
return {
    "hrsh7th/nvim-cmp",
    after = "nvim-autopairs",
    requires = {
        "f3fora/cmp-spell",
        "hrsh7th/cmp-buffer",
        "andersevenrud/cmp-tmux",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "ray-x/cmp-treesitter",
        { "tzachar/cmp-tabnine", run = "./install.sh" },
    },
    config = function()
        require "config.plugins.configs.cmp"
    end,
}
