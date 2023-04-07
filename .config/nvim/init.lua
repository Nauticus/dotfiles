local cmd = vim.cmd
local g = vim.g

cmd([[cd %:p:h]])
vim.env.NVIMRC = "~/.config/nvim/init.lua"

g.mapleader = vim.api.nvim_replace_termcodes("<Space>", true, true, true)
g.maplocalleader = "\\"

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python_provider = 0
g.python3_host_prog = os.getenv("HOME") .. "/.pyenv/versions/3.9.4/bin/python"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("config.plugins", {
    performance = {
        rtp = {
            disabled_plugins = { "matchparen", "matchit", "netrw", "tutor" },
        },
    },
    ui = {
        border = "rounded",
    },
    change_detection = {
        notify = false,
    },
    diff = {
        cmd = "diffview.nvim",
    },
})

require("config.core.utils")
require("config.core.opts")
require("config.core.autocmd")
require("config.core.mappings")
