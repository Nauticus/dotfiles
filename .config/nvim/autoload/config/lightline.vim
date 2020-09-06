function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:]
    endif
    return expand('%')
endfunction

function! config#lightline#Init()
    let g:lightline = {
                \ 'colorscheme': 'gruvbox',
                \ 'active': {
                \   'left': [['mode'], ['gitbranch','filename','readonly','modified']]
                \ },
                \ 'component_function': {
                \   'filename': 'LightlineFilename',
                \   'gitbranch': 'FugitiveHead'
                \ }
                \ }
endfunction
