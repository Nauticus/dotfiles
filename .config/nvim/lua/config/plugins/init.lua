local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd "packadd packer.nvim"

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-obsession'
    use 'tpope/vim-unimpaired'
    use 'mfussenegger/nvim-dap'

    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = [[require('config.plugins.lualine')]]
    }
    use { 'christoomey/vim-tmux-navigator', config = [[vim.g.tmux_navigator_disable_when_zoomed = 0]] }

    use 'tpope/vim-commentary'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    use { 'editorconfig/editorconfig-vim', config = [[vim.g.EditorConfig_preserve_formatoptions = 1]] }
    use { 'mbbill/undotree' }

    use { "folke/which-key.nvim" }

    use {
        'justinmk/vim-dirvish',
        requires = { { 'kristijanhusak/vim-dirvish-git' } },
        config = [[require('config.plugins.dirvish')]]
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = [[require('config.plugins.telescope')]],
        requires = {
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' }
        }
    }

    use 'tpope/vim-surround'

    -- use { 'justinmk/vim-sneak', config = [[require('config.plugins.sneak')]] }
    use { 'ggandor/lightspeed.nvim', config = [[require('config.plugins.lightspeed')]] }

    use {
        'lewis6991/gitsigns.nvim',
        config = [[require('config.plugins.gitsigns')]],
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use { 'rafcamlet/nvim-luapad' }

    use 'tpope/vim-fugitive'
    use 'junegunn/gv.vim'
    use 'junegunn/vim-easy-align'

    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'

    use { 'NTBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' } }

    use { 'ruifm/gitlinker.nvim', config = [[require('config.plugins.gitlinker')]], requires = 'nvim-lua/plenary.nvim' }

    use 'folke/tokyonight.nvim'
    use 'shaunsingh/moonlight.nvim'
    use 'gruvbox-community/gruvbox'
    use { "mhartington/oceanic-next", commit = "29d694b9f6323c90fb0f3f54239090370caa99fb" }
    use 'monsonjeremy/onedark.nvim'
    use 'ishan9299/nvim-solarized-lua'

    use {
        'hrsh7th/nvim-compe',
        config = [[require('config.plugins.compe')]],
        requires = {
            {
                'SirVer/ultisnips',
                config = function()
                    vim.g.UltiSnipsExpandTrigger = "<nop>"
                end
            },
            { 'honza/vim-snippets' }
        }
    }
    use { 'neovim/nvim-lspconfig', config = [[require('config.plugins.lsp')]] }
    use { 'kabouzeid/nvim-lspinstall' }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use { 'windwp/nvim-autopairs', config = [[require('config.plugins.autopairs')]] }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = [[require('config.plugins.treesitter')]] }
    use { 'nvim-treesitter/nvim-tree-docs', requires = { 'Olical/aniseed', tag = "v3.18.0" } }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/completion-treesitter'

    use 'norcalli/nvim-colorizer.lua'

    -- Project Related
    use 'digitaltoad/vim-pug'
    use 'posva/vim-vue'

    use 'tpope/vim-markdown'

    use {
        'iamcco/markdown-preview.nvim',
        run = function()
            vim.fn['mkdp#util#install']()
        end,
        ft = { 'markdown' }
    }
end)
