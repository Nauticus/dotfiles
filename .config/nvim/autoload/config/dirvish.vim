function! s:CreateFile()
    let filename = input('File name: ')
    if trim(filename) == ''
	redraw
	echo 'No filename given'
	return
    elseif !empty(glob(filename))
	redraw
	echomsg printf('"%s" already exists.', filename)
	return
    endif
    let path = expand("%") . filename
    let cmd = printf(':!touch "%s"', path)
    silent execute(cmd)
    normal R
endfunction

function! s:DeleteItemUnderCursor()
    let target = getline('.')
    echo target
    let filename = fnamemodify(target, ':t')
    let cmd = (isdirectory(target)) ?  printf('rm -rf "%s" /s /q',target) : printf('rm "%s"', target)
    silent execute(printf(':!%s', cmd))
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

function! config#dirvish#Init()
    let g:dirvish_mode = ':sort ,^.*[\/],'
    let g:dirvish_relative_paths = 0

    augroup dirvish_config
	autocmd!
	autocmd FileType dirvish silent nmap <silent><buffer> <leader>td :!tmux split-window -h -l 80 -c <C-R>=expand('%:p:h')<CR><CR><CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>dd :call <SID>DeleteItemUnderCursor()<CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>rn :call <SID>RenameItemUnderCursor()<CR>
	autocmd FileType dirvish nnoremap <silent> <buffer> <leader>e :call <SID>CreateFile()<CR>
    augroup END
endfunction

