function! s:CreateDirectory() abort
    let dirname = input('Directory name: ')
    if trim(dirname) == ''
	return
    endif
    let dirpath = expand("%") . dirname
    if isdirectory(dirpath)
	redraw
	echomsg printf('"%s" already exists.', dirpath)
	return
    endif
    let output = system("mkdir -p " . dirpath)
    if v:shell_error
	call s:logError(output)
    endif
    normal R
endfunction

function! s:RenameItemUnderCursor()
    let target = getline('.')
    let filename = fnamemodify(target, ':t')
    let path = fnamemodify(target, ':p:h')
    let newname = input('Rename into: ', filename)
    let newpath = path . '/' . newname
    silent execute(printf(':!mv "%s" "%s"',target,newpath))
    normal R
endfunction

function! s:DirvishTouch(...)
    let l:argument = map(copy(a:000), 'expand("%:h") . "/" . v:val')
    silent execute printf(':!touch %s', join(l:argument, ' '))
endfunction

function! config#dirvish#Init()
    let g:dirvish_mode = ':sort ,^.*[\/],'
    let g:dirvish_relative_paths = 0

    command! -nargs=+ DirvishTouch call <SID>DirvishTouch(<f-args>)

    augroup dirvish_config
	autocmd!
	autocmd FileType dirvish silent nmap <silent><buffer> <leader>td :!tmux split-window -h -l 80 -c <C-R>=expand('%:p:h')<CR><CR><CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>rn :call <SID>RenameItemUnderCursor()<CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>cd :call <SID>CreateDirectory()<CR>
    augroup END
endfunction

