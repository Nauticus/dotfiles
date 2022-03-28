local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd "packadd packer.nvim"

local packer_utils = require "packer.util"

require("packer").init {
    max_jobs = 6,
    profile = { enable = false },
    compile_path = packer_utils.join_paths(vim.fn.stdpath "config", "lua", "packer_compiled.lua"),
}

local function use_colorschemes(use)
    use {
        "rebelot/kanagawa.nvim",
        disable = false,
        config = function()
            local colors = require("kanagawa.colors").setup()

            require("kanagawa").setup {
                undercurl = true,
                transparent = true,
                overrides = {
                    TelescopeBorder = { fg = colors.fujiGray, bg = "NONE" },
                },
            }
            vim.cmd "colorscheme kanagawa"
        end,
    }
end

local function use_utilities(use)
    use "lewis6991/impatient.nvim"
    use {
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup {}
            require("pretty-fold.preview").setup_keybinding()
        end,
    }
    use {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup { stages = "static" }
            vim.notify = require "notify"
        end,
    }
    use { "Asheq/close-buffers.vim" }
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                window = { width = 0.70, backdrop = 0.5 },
                plugins = { options = { showcmd = false }, twilight = { enabled = false } },
            }
        end,
    }
    use {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup {
                context = 0,
                expand = {
                    "function_declaration",
                    "function_call_expression",
                    "expression_statement",
                    "function",
                    "function_definition",
                    "method_declaration",
                    "method",
                    "table",
                    "if_statement",
                    "type_declaration",
                },
            }
        end,
    }
    use {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux.init").setup { navigation = { enable_default_keybindings = true } }
        end,
    }
    use "romainl/vim-devdocs"
    use "tpope/vim-obsession"
    use {
        "nanozuki/tabby.nvim",
        after = "kanagawa.nvim",
        config = function()
            require "config.plugins.tabby"
        end,
    }
    use "tpope/vim-unimpaired"
    use "wellle/visual-split.vim"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require "config.plugins.lualine"
        end,
    }
    use "gpanders/editorconfig.nvim"
    use { "mbbill/undotree", opt = true, cmd = "UndotreeToggle" }
    use {
        "folke/which-key.nvim",
        config = function()
            require "config.plugins.which-key"
        end,
    }
    use "tpope/vim-surround"
    use {
        "ggandor/lightspeed.nvim",
        config = function()
            vim.cmd [[autocmd User LightspeedLeave set scrolloff=4]]
            local opts = require("lightspeed").opts

            table.remove(opts.safe_labels, 1)
            table.remove(opts.labels, 1)

            require("lightspeed").setup {
                force_beacons_into_match_width = true,
                match_only_the_start_of_same_char_seqs = true,
                ignore_case = true,
            }
        end,
    }
    use {
        "justinmk/vim-sneak",
        disable = true,
        config = function()
            require "config.plugins.sneak"
        end,
    }
    use {
        "phaazon/hop.nvim",
        disable = true,
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require("hop").setup {
                keys = "stovpdygfblzhckieuran",
                quit_key = "<C-[>",
                char2_fallback_key = "<C-[>",
            }
            vim.api.nvim_set_keymap("n", "s", "<cmd>HopChar2AC<cr>", { silent = true })
            vim.api.nvim_set_keymap("n", "S", "<cmd>HopChar2BC<cr>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>HopWord<cr>", { silent = true })
        end,
    }
    use "junegunn/vim-easy-align"
    use {
        "lukas-reineke/indent-blankline.nvim",
        disable = true,
        branch = "develop",
        config = function()
            require "config.plugins.blankline"
        end,
    }
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup { scss = { rgb_fn = true }, css = { rgb_fn = true } }
        end,
    }
    use "tpope/vim-markdown"
    use {
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
    }
end

local function use_git(use)
    use { "tpope/vim-fugitive" }
    use { "sindrets/diffview.nvim" }
    use "junegunn/gv.vim"
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "config.plugins.gitsigns"
        end,
        requires = { "nvim-lua/plenary.nvim" },
    }
end

local function use_debug(use)
    use {
        "rcarriga/nvim-dap-ui",
        config = function()
            require("dapui").setup()
        end,
        requires = {
            "mfussenegger/nvim-dap",
            config = function()
                require "config.plugins.dap"
            end,
        },
    }
end

local function use_lsp(use)
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/nvim-lsp-installer",
            "b0o/schemastore.nvim",
        },
        config = function()
            require "config.plugins.lsp"
        end,
    }
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "folke/lua-dev.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end,
    }
    use {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup {}
        end,
    }
end

local function use_search(use)
    use { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" }
    use {
        "junegunn/fzf.vim",
        config = function()
            require "config.plugins.fzf"
        end,
    }
    use {
        "nvim-telescope/telescope.nvim",
        config = function()
            require "config.plugins.telescope"
        end,
        requires = {
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "kyoh86/telescope-windows.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
    }
end

local function use_syntax(use)
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require "config.plugins.treesitter"
        end,
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/nvim-treesitter-refactor"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/completion-treesitter"
    use { "JoosepAlviste/nvim-ts-context-commentstring", requires = { "tpope/vim-commentary" } }
    use {
        "windwp/nvim-autopairs",
        disable = true,
        config = function()
            require "config.plugins.autopairs"
        end,
    }
    use { "windwp/nvim-ts-autotag" }
    use {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { ["method"] = "popup" }
        end,
    }
    use { "digitaltoad/vim-pug" }
    use {
        "danymat/neogen",
        config = function()
            require("neogen").setup {
                enabled = true,
            }
        end,
        requires = "nvim-treesitter/nvim-treesitter",
    }
end

local function use_navigation(use)
    use {
        "tamago324/lir.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "tamago324/lir-git-status.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require "config.plugins.lir"
        end,
    }
end

local function use_completion(use)
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            { "andersevenrud/cmp-tmux" },
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-cmdline",
            "ray-x/cmp-treesitter",
            { "tzachar/cmp-tabnine", run = "./install.sh" },
        },
        config = function()
            require "config.plugins.cmp"
        end,
    }
end

local function use_db(use)
    use {
        "tpope/vim-dadbod",
        opt = true,
        cmd = "DBUI",
        requires = { "kristijanhusak/vim-dadbod-ui" },
    }
end

local function use_notes(use)
    use {
        "nvim-orgmode/orgmode",
        config = function()
            require("orgmode").setup {}
        end,
    }
end

local function use_test(use)
    use { "vim-test/vim-test" }
end

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use_colorschemes(use)
    use_utilities(use)
    use_git(use)
    use_lsp(use)
    use_search(use)
    use_syntax(use)
    use_navigation(use)
    use_completion(use)
    use_db(use)
    use_debug(use)
    -- use_notes(use)
    use_test(use)
end)
