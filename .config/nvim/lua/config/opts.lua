local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'updatetime', 1000)
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

vim.g.loaded_netrwPlugin = 1

vim.g.completion_confirm_key = ""
