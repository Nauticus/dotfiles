vim.cmd [[
    augroup formatoptions 
        autocmd!
        autocmd BufEnter * setlocal formatoptions-=c formatoptions-=o
    augroup END
]]

vim.cmd [[
augroup dirvishbuf
    autocmd!
    autocmd FileType dirvish setlocal relativenumber signcolumn=no nonumber
augroup END
]]

vim.cmd [[
	augroup terminaloptions
		autocmd!
		autocmd TermOpen * setlocal nonumber bufhidden=hide norelativenumber nospell
		autocmd TermOpen,TermEnter * startinsert
	augroup END
]]
