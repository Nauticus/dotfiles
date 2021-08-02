local cmd = vim.cmd
local g = vim.g

cmd [[cd %:p:h]]
vim.env.NVIMRC = "~/.config/nvim/init.lua"

cmd [[let mapleader = "\<Space>"]]
cmd [[let g:mapleader = "\<Space>"]]

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python_provider = 0
g.python3_host_prog = os.getenv('HOME') .. '/.pyenv/versions/3.9.4/bin/python'

require 'config.opts'
require 'config.plugins'
require 'config.autocmd'
require 'config.utils'
require 'config.mappings'

g.tokyonight_transparent = true
g.tokyonight_sidebars = { 'qf', 'dirvish', 'packer' }
g.tokyonight_lualine_bold = true
g.markdown_folding = 1

cmd [[colo tokyonight]]

cmd [[au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500 })]]
