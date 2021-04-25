local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'hoob3rt/lualine.nvim', config = [[require('config.plugins.lualine')]] }
    use 'tpope/vim-commentary'
    use 'editorconfig/editorconfig-vim'

    use {
        'justinmk/vim-dirvish',
        requires = { { 'kristijanhusak/vim-dirvish-git' } },
        config = [[require('config.plugins.dirvish')]]
    }

    use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    use { 'junegunn/fzf.vim', config = [[require('config.plugins.fzf')]] }

    use 'tpope/vim-surround'

    use { 'justinmk/vim-sneak', config = [[require('config.plugins.sneak')]] }

    use {
        'lewis6991/gitsigns.nvim',
        config = [[require('config.plugins.gitsigns')]],
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tommcdo/vim-fubitive'

    use 'gruvbox-community/gruvbox'
    use 'lifepillar/vim-gruvbox8'

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

    use { 'windwp/nvim-autopairs', config = [[require('config.plugins.autopairs')]] }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = [[require('config.plugins.treesitter')]] }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/completion-treesitter'
end)
