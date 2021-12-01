local o = vim.opt

o.guifont = "JetBrainsMono Nerd Font:h12"
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor1,a:blinkwait0-blinkon400-blinkoff300"
o.diffopt = vim.o.diffopt .. ",algorithm:patience"
o.updatetime = 700
o.timeoutlen = 500
o.clipboard = "unnamed"
o.completeopt = "menu,menuone,noselect"
o.termguicolors = true
o.wildoptions = "pum"
o.pumblend = 0
o.hidden = true
o.splitright = true
o.splitbelow = true
o.scrolloff = 0
o.mouse = "n"
o.ignorecase = true
o.smartcase = true
o.smarttab = true
o.hlsearch = false
-- o.guicursor = ""
o.signcolumn = "yes:2"
o.number = true
o.relativenumber = true
o.cursorline = true
o.breakindent = false
o.linebreak = false
o.wrap = true
o.cpo = o.cpo + "n"
o.list = true
o.showbreak = "»"
o.swapfile = false
o.undofile = true
o.tabstop = 4
o.shiftwidth = 4
o.showtabline = 2
o.softtabstop = 4
o.expandtab = true
o.smartindent = false
o.formatoptions = string.gsub(vim.bo.formatoptions, "[co]", "")
o.ssop = o.ssop - { "blank", "help", "buffers" } + { "terminal" }
o.fillchars = { vert = " " }

vim.g.completion_confirm_key = ""
