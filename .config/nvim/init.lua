local cmd = vim.cmd
local g = vim.g

cmd [[cd %:p:h]]
vim.env.NVIMRC = "~/.config/nvim/init.lua"

g.mapleader = vim.api.nvim_replace_termcodes("<Space>", true, true, true)
g.maplocalleader = ","

g.loaded_perl_provider = 0
-- g.loaded_netrwPlugin = 0
g.loaded_ruby_provider = 0
g.loaded_python_provider = 0
g.python3_host_prog = os.getenv "HOME" .. "/.pyenv/versions/3.9.4/bin/python"

if not pcall(require, "impatient") then
    vim.notify("Failed to load impatient.nvim", vim.log.levels.ERROR)
end

require "config.plugins"
require "config.core.utils"
require "config.core.opts"
require "config.core.autocmd"
require "config.core.mappings"
-- require "config.core.debug"
