return {
    -- "~/code/personal/nvim_plugins/shape.nvim",
    "nanotee/luv-vimdocs",
    "milisims/nvim-luaref",
    "lewis6991/impatient.nvim",
    "Asheq/close-buffers.vim",
    "gpanders/editorconfig.nvim",
    "nvim-pack/nvim-spectre",
    {
        "luukvbaal/statuscol.nvim",
        disable = true,
        config = function()
            require("statuscol").setup {
                separator = "|",
                reeval = true,
                setopt = true,
                order = "FNSs"
            }
        end,
    },
    {
        "mbbill/undotree",
        opt = true,
        cmd = "UndotreeToggle",
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup { scss = { rgb_fn = true }, css = { rgb_fn = true } }
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
    },
    {
        "folke/which-key.nvim",
        disable = false,
    },
    {
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup {}
            -- require("pretty-fold.preview").setup_keybinding()
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup { stages = "static" }
            vim.notify = require "notify"
        end,
    },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup {
                copy_sync = { enable = false },
            }
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                padding = true,
            }
        end,
    },
    {
        "ThePrimeagen/harpoon",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "zbirenbaum/neodim",
        config = function()
            require("neodim").setup()
        end,
    },
    { "jbyuki/venn.nvim" },
    { "ThePrimeagen/vim-be-good" },
}
