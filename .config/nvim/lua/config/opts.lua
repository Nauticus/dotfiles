local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then
        scopes['o'][key] = value
    end
end

opt('o', 'guifont', 'JetBrainsMono Nerd Font:h12')
opt('o', 'diffopt', vim.o.diffopt .. ',algorithm:patience')
opt('o', 'updatetime', 700)
opt('o', 'timeoutlen', 500)
opt('o', 'clipboard', 'unnamed')
opt('o', 'completeopt', 'menuone,noinsert,noselect')
opt('o', 'termguicolors', true)
opt('o', 'wildoptions', 'pum')
opt('o', 'pumblend', 17)
opt('o', 'hidden', true)
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)
opt('o', 'scrolloff', 10)
opt('o', 'mouse', 'n')
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'smarttab', true)
opt('o', 'hlsearch', false)
opt('o', 'guicursor', '')
opt('w', 'signcolumn', 'yes:2')
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'cursorline', true)
opt('w', 'breakindent', true)
opt('w', 'linebreak', true)
opt('b', 'swapfile', false)
opt('b', 'undofile', true)
opt('b', 'tabstop', 4)
opt('b', 'shiftwidth', 4)
opt('b', 'softtabstop', 4)
opt('b', 'expandtab', true)
opt('b', 'smartindent', true)
opt('b', 'formatoptions', string.gsub(vim.bo.formatoptions, "[co]", ""))

vim.g.loaded_netrwPlugin = 1
vim.g.completion_confirm_key = ""
