return {
    { dir = "~/code/personal/nvim-routine" },
    {
        "loctvl842/monokai-pro.nvim",
        enabled = false,
        config = function()
            require("monokai-pro").setup({
                transparent_background = true,
                filter = "pro",
            })

            vim.cmd.colorscheme("monokai-pro")
        end,
    },
    {
        "catppuccin/nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            custom_highlights = function(colors)
                return {
                    OilDir = { fg = colors.blue },
                    GutterSep = { fg = colors.base },
                    MatchParen = { bg = colors.surface0, bold = true },
                    MatchWord = { bg = colors.surface0, underdashed = true, bold = true },
                    CmpCompletionWindow = { fg = colors.surface2 },
                    CmpDocumentationWindow = { fg = colors.rosewater },
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = false,
                telescope = true,
                notify = true,
                mini = false,
                mason = true,
                semantic_tokens = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
