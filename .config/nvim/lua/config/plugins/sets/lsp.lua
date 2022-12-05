return {
    {
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "b0o/schemastore.nvim",
        "folke/neodev.nvim",
        "kosayoda/nvim-lightbulb",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        requires = "PlatyPew/format-installer.nvim",
        after = "nvim-lspconfig",
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
