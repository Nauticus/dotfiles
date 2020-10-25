function! config#fzf#Init()
    let $FZF_DEFAULT_OPTS = '-m --ansi --preview "bat --color=always --style=header,grid --line-range :100 {}"'
    let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'

    let g:fzf_preview_window = 'right:45%'
    let g:fzf_buffers_jump = 1

    if exists('$TMUX')
        let g:fzf_layout = { 'tmux': '-p90%,90%' }
    else
        let g:fzf_layout = { 'down': '40%' }
    endif

    inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
endfunction
