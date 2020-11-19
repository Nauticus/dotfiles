function! s:ShortenPath()
    let name = ""
    let fragments = split(expand('%:.'), "/") 
    let i = 1
    for s in fragments
        let parent = name
        if  i > len(subs) -3
            let name = parent . '/' . s
        elseif i == 1
            let name = s
        else
            let name = parent . '/' . strpart(s, 0, 4)
        endif
        let i += 1
    endfor
    return name
endfunction

function! LightlineFilename()
    return expand('%:.')
    " return <SID>ShortenPath()
endfunction

function! LightlineFugitive()
    return ' ' . FugitiveHead()
endfunction

function! LightlineRoot()
    return fnamemodify(getcwd(), ':t')
endfunction

function! FileIcon()
    return isdirectory(expand('%')) ? '' : WebDevIconsGetFileTypeSymbol()
endfunction

function! config#lightline#Init()
    let g:lightline = {
                \ 'colorscheme': 'gruvbox',
                \ 'active': {
                \   'left': [['mode'], ['fileicon'], ['root'], ['filename','readonly','modified']],
                \   'right': [['gitbranch'], ['filetype', 'fileformat']],
                \ },
                \ 'inactive': {
                \   'left': [['fileicon', 'filename', 'modified']],
                \ },
                \ 'separator': { 'left': '', 'right': '' },
                \ 'subseparator': { 'left': '', 'right': '' },
                \ 'component': {
                \   'modified': '%m',
                \ },
                \ 'component_function': {
                \   'fileicon': 'FileIcon',
                \   'filename': 'LightlineFilename',
                \   'gitbranch': 'LightlineFugitive',
                \   'root': 'LightlineRoot',
                \ },
                \ 'mode_map': {
                \   'n' : 'N',
                \   'i' : 'I',
                \   'R' : 'R',
                \   'v' : 'V',
                \   'V' : 'V-L',
                \   "\<C-v>": 'V-B',
                \   'c' : 'C',
                \   's' : 'S',
                \   'S' : 'S-L',
                \   "\<C-s>": 'S-B',
                \   't': 'T',
                \ }
                \ }
endfunction
