vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor1,a:blinkwait0-blinkon400-blinkoff300"
vim.opt.diffopt = vim.o.diffopt .. ",algorithm:patience,linematch:60"
vim.opt.updatetime = 700
vim.opt.timeoutlen = 200
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.termguicolors = true
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 0
vim.opt.pumheight = 15
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 4
vim.opt.mouse = "n"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.hlsearch = false
vim.opt.signcolumn = "yes:2"
vim.opt.numberwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.breakindent = false
vim.opt.linebreak = false
vim.opt.wrap = false
vim.opt.cpo = vim.opt.cpo + "n"
vim.opt.list = true
vim.opt.showbreak = "»"
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showtabline = 1
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = false
vim.opt.formatoptions = string.gsub(vim.bo.formatoptions, "[co]", "")
vim.opt.ssop = vim.opt.ssop - { "blank", "help", "buffers" } + { "terminal" }
vim.opt.fillchars:append {
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┨",
    vertright = "┣",
    verthoriz = "╋",
}
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.cmdheight = 1 -- TODO: Set to 0 when https://github.com/neovim/neovim/pull/18961 to be merged.
vim.opt.foldenable = false
-- vim.opt.statuscolumn = '%s %=%{v:relnum?v:relnum:v:lnum} │ '
-- vim.opt.statuscolumn = "%s%=%l%= %{% %C == '' ? '|' : '%C' %}"
-- vim.o.statuscolumn = "%=%l%s%C"
-- vim.opt.statuscolumn = vim.fn.join({
--   -- line number
--   '%=%{&nu? (&rnu&&(v:relnum) ? v:relnum : v:lnum." ") : ""}',
--   -- signs
--   '%s',
--   -- fold
--   '%C%',
--   -- space
--   '#Normal#%{&nu? " " : ""}',
-- }, '')
-- oauaoeu.oeu
