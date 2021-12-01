local cmd = vim.cmd
local g = vim.g

cmd [[cd %:p:h]]
vim.env.NVIMRC = "~/.config/nvim/init.lua"

cmd [[let mapleader = "\<Space>"]]
cmd [[let g:mapleader = "\<Space>"]]

g.loaded_perl_provider = 0
g.loaded_netrwPlugin = 1
g.loaded_ruby_provider = 0
g.loaded_python_provider = 0
g.python3_host_prog = os.getenv('HOME') .. '/.pyenv/versions/3.9.4/bin/python'

require 'config.opts'
require 'config.plugins'
require 'config.autocmd'
require 'config.utils'
require 'config.mappings'
require 'config.debug'
