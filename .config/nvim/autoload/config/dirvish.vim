function! config#dirvish#Init()
    let g:dirvish_mode = ':sort ,^.*[\/],'
    let g:dirvish_relative_paths = 0

    augroup dirvish_config
        autocmd!
        autocmd FileType dirvish silent nmap <silent><buffer> <leader>td :!tmux split-window -h -l 80 -c <C-R>=expand('%:p:h')<CR><CR><CR>
    augroup END
endfunction
