vim.cmd [[cd %:p:h]]
vim.env.NVIMRC = "~/.config/nvim/init.lua"

vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', {noremap = true})

require 'config.opts'
require 'config.utils'
require 'config.plugins'
require 'config.mappings'

vim.cmd [[colo gruvbox]]

vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500 })]]
