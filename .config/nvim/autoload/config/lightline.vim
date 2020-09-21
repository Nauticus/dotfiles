function! LightlineFilename()
    return expand('%:p:~')
endfunction

function! config#lightline#Init()
    let g:lightline = {
                \ 'colorscheme': 'blue-moon',
                \ 'active': {
                \   'left': [['mode'], ['gitbranch','filename','readonly','modified']],
                \ },
                \ 'component_function': {
                \   'filename': 'LightlineFilename',
                \   'gitbranch': 'FugitiveHead'
                \ }
                \ }
endfunction
