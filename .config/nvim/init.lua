local cmd = vim.cmd
local g = vim.g

cmd [[cd %:p:h]]
vim.env.NVIMRC = "~/.config/nvim/init.lua"

cmd [[let mapleader = "\<Space>"]]
cmd [[let g:mapleader = "\<Space>"]]

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python_provider = 0

require 'config.opts'
require 'config.plugins'
require 'config.autocmd'
require 'config.utils'
require 'config.mappings'

cmd [[colo tokyonight]]
g.tokyonight_style = "storm"

cmd [[au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500 })]]
