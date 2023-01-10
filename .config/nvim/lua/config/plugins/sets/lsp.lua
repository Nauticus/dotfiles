return {
    {
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "b0o/schemastore.nvim",
        "folke/neodev.nvim",
        "kosayoda/nvim-lightbulb",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
        "jayp0521/mason-null-ls.nvim",
    },
    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        after = "nvim-lspconfig",
    },
    {
        "j-hui/fidget.nvim",
        after = "nvim-lspconfig",
    },
}
