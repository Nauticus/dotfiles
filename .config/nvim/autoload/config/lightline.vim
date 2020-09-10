function! LightlineFilename()
    return expand('%:p:~')
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
