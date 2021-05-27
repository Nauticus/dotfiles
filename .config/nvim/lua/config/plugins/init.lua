local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd "packadd packer.nvim"

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim', opt = true }
    use 'tpope/vim-obsession'
    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = [[require('config.plugins.lualine')]]
    }
    use { 'christoomey/vim-tmux-navigator', config = [[vim.g.tmux_navigator_disable_when_zoomed = 1]] }

    use 'tpope/vim-commentary'
    use { 'editorconfig/editorconfig-vim', config = [[vim.g.EditorConfig_preserve_formatoptions = 1]] }
    use { 'mbbill/undotree' }
    -- use { 'AckslD/nvim-whichkey-setup.lua', requires = { 'liuchengxu/vim-which-key' } }

    use { "folke/which-key.nvim" }

    -- use { 'tamago324/lir.nvim', config = [[require('config.plugins.lir')]] }

    use {
        'justinmk/vim-dirvish',
        requires = { { 'kristijanhusak/vim-dirvish-git' } },
        config = [[require('config.plugins.dirvish')]]
    }

    -- use { 'junegunn/fzf', ?ir = '~/.fzf', run = './install --all' }
    -- use { 'junegunn/fzf.vim', config = [[require('config.plugins.fzf')]] }

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

    use { 'justinmk/vim-sneak', config = [[require('config.plugins.sneak')]] }

    use {
        'lewis6991/gitsigns.nvim',
        config = [[require('config.plugins.gitsigns')]],
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use { 'rafcamlet/nvim-luapad' }

    use 'tpope/vim-fugitive'
    use 'junegunn/gv.vim'
    use 'tpope/vim-rhubarb'
    use 'tommcdo/vim-fubitive'

    use 'Th3Whit3Wolf/one-nvim'
    use 'folke/tokyonight.nvim'

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

    use { 'windwp/nvim-autopairs', config = [[require('config.plugins.autopairs')]] }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = [[require('config.plugins.treesitter')]] }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/completion-treesitter'

    use 'norcalli/nvim-colorizer.lua'

    -- Project Related
    use 'digitaltoad/vim-pug'
    use 'posva/vim-vue'
end)
