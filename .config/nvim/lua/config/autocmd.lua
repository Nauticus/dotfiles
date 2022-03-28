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

vim.cmd [[
    augroup ftfoldmethod
        autocmd!
        autocmd FileType git setlocal foldmethod=syntax foldlevel=0
    augroup END
]]

-- vim.cmd [[
--     augroup cursorline
--         autocmd!
--         autocmd InsertLeave,WinEnter * set cursorline
--         autocmd InsertEnter,WinLeave * set nocursorline
--     augroup END
-- ]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */nvim/lua/config/plugins/init.lua source <afile>
  augroup END
]]

vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500 })]]
