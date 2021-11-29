local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd "packadd packer.nvim"

require("packer").init { max_jobs = 4, profile = { enable = false } }

local function use_colorschemes(use)
    use {
        "eddyekofo94/gruvbox-flat.nvim",
        disable = true,
        config = function()
            vim.cmd [[colo gruvbox-flat]]
        end
    }
    use {
        "folke/tokyonight.nvim",
        disable = true,
        config = function()
            vim.cmd [[colorscheme tokyonight]]

            local c = require("tokyonight.colors").setup(require("tokyonight.config"))
            local util = require("tokyonight.util")

            util.syntax({ ObsessionStatus = { fg = c.red, bg = c.bg }, TabbyWinActive = { bg = c.bg_visual } })
        end
    }
    use {
        "ful1e5/onedark.nvim",
        disable = false,
        config = function()
            vim.cmd [[colo onedark]]

            local c = require("onedark.colors").setup(require("onedark.config"))
            local util = require("onedark.util")

            util.syntax({
                ObsessionStatus = { fg = c.red, bg = c.bg },
                TabbyWinActive = { bg = c.bg_visual },
                TabbyCwd = { bg = c.red, fg = c.bg, style = "bold" },
                TSTagDelimiter = { fg = c.fg_dark }
            })

            vim.defer_fn(function()
                util.syntax({
                    TabLineActiveTab = { bg = c.red, fg = c.bg, style = "bold" },
                    TabLineInactiveTab = { bg = c.bg2, fg = c.red },
                    VertSplit = { bg = c.bg2 },
                    StatuslineTerm = { bg = c.bg2 },
                    StatuslineTermNC = { bg = c.bg2 },
                    NvimTreeFolderName = { fg = c.red },
                    NvimTreeOpenedFolderName = { fg = c.orange, style = "bold" },
                    IndentBlanklineChar = { fg = util.darken(c.fg_gutter, 0.4, c.bg) },
                    IndentBlanklineContextChar = { fg = util.darken(c.fg_gutter, 0.9, c.bg) },
                    GitSignsAdd = { fg = util.blend(c.git_signs.add, c.bg, 0.5), bg = c.bg_linenumber },
                    GitSignsChange = { fg = util.blend(c.git_signs.change, c.bg, 0.5), bg = c.bg_linenumber },
                    GitSignsDelete = { fg = util.blend(c.git_signs.delete, c.bg, 0.5), bg = c.bg_linenumber },
                    GitSignsCurrentLineBlame = { fg = util.darken(c.fg_gutter, 0.6, c.bg) },
                    scssTSString = { fg = c.syntax.scss.string }
                })
            end, 101)
        end
    }
end

local function use_utilities(use)
    use { "Asheq/close-buffers.vim" }
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                window = { width = .70, backdrop = 0.5 },
                plugins = { options = { showcmd = false }, twilight = { enabled = false } }
            }
        end
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
                    "type_declaration"
                }
            }
        end
    }
    use {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                -- overwrite default configuration
                -- here, e.g. to enable default bindings
                copy_sync = {
                    -- enables copy sync and overwrites all register actions to
                    -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
                    enable = false
                },
                navigation = {
                    -- enables default keybindings (C-hjkl) for normal mode
                    enable_default_keybindings = true
                },
                resize = {
                    -- enables default keybindings (A-hjkl) for normal mode
                    enable_default_keybindings = true
                }
            })
        end
    }
    use "romainl/vim-devdocs"
    use "tpope/vim-obsession"
    use {
        "kwkarlwang/bufresize.nvim",
        config = function()
            require("bufresize").setup()
        end
    }
    use {
        "nanozuki/tabby.nvim",
        after = "onedark.nvim",
        config = function()
            require("config.plugins.tabby")
        end
    }
    use "tpope/vim-unimpaired"
    use "wellle/visual-split.vim"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = [[require('config.plugins.lualine')]]
    }
    use "tpope/vim-commentary"
    use { "editorconfig/editorconfig-vim", config = [[vim.g.EditorConfig_preserve_formatoptions = 1]] }
    use { "mbbill/undotree", opt = true, cmd = "UndotreeToggle" }
    use { "folke/which-key.nvim", config = [[require('config.plugins.which-key')]] }
    use "tpope/vim-surround"
    use {
        "ggandor/lightspeed.nvim",
        config = function()
            require("lightspeed").setup { exit_after_idle_msecs = { labeled = 2000, unlabeled = 1500 } }
        end
    }
    -- use { "justinmk/vim-sneak", config = [[require('config.plugins.sneak')]] }
    use "junegunn/vim-easy-align"
    use { "lukas-reineke/indent-blankline.nvim", branch = "develop", config = [[require('config.plugins.blankline')]] }
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ scss = { rgb_fn = true }, css = { rgb_fn = true } })
        end
    }
    use "tpope/vim-markdown"
    use {
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" }
    }
end

local function use_git(use)
    use { "tpope/vim-fugitive" }
    use { "sindrets/diffview.nvim" }
    use "junegunn/gv.vim"
    use {
        "lewis6991/gitsigns.nvim",
        config = [[require('config.plugins.gitsigns')]],
        requires = { "nvim-lua/plenary.nvim" }
    }
end

local function use_debug(use)
    use {
        "rcarriga/nvim-dap-ui",
        config = [[require("dapui").setup()]],
        requires = { "mfussenegger/nvim-dap", config = [[require('config.plugins.dap')]] }
    }
end

local function use_lsp(use)
    use {
        "neovim/nvim-lspconfig",
        requires = { "williamboman/nvim-lsp-installer" },
        config = [[require('config.plugins.lsp')]]
    }
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "folke/lua-dev.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }
end

local function use_search(use)
    use { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" }
    use { "junegunn/fzf.vim", config = [[require('config.plugins.fzf')]] }
    use {
        "nvim-telescope/telescope.nvim",
        config = [[require('config.plugins.telescope')]],
        requires = {
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-live-grep-raw.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" }
        }
    }
end

local function use_syntax(use)
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('config.plugins.treesitter')]] }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/nvim-treesitter-refactor"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/completion-treesitter"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use { "windwp/nvim-autopairs", config = [[require('config.plugins.autopairs')]] }
    use { "windwp/nvim-ts-autotag" }
    use {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { ["method"] = "popup" }
        end
    }
end

local function use_navigation(use)
    use {
        "kyazdani42/nvim-tree.lua",
        config = [[require('config.plugins.tree')]],
        requires = "kyazdani42/nvim-web-devicons"
    }
end

local function use_completion(use)
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            { "andersevenrud/compe-tmux", branch = "cmp" },
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-cmdline",
            "ray-x/cmp-treesitter"
        },
        config = [[require('config.plugins.cmp')]]
    }
end

local function use_db(use)
    use { "tpope/vim-dadbod", opt = true, cmd = "DBUI", requires = { "kristijanhusak/vim-dadbod-ui" } }
end

local function use_notes(use)
    use {
        "kristijanhusak/orgmode.nvim",
        config = function()
            require("orgmode").setup {}
        end
    }
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
    use_notes(use)
end)
