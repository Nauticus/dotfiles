function! config#fzf#Init()
    let $FZF_DEFAULT_OPTS = '-m'
    let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'

    let g:fzf_preview_window = 'right:35%'
    let g:fzf_buffers_jump = 1

    if exists('$TMUX')
        let g:fzf_layout = { 'tmux': '-p100%,40% -y53' }
    else
        let g:fzf_layout = { 'down': '40%' }
    endif
endfunction
