let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Code/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 .config/bat/config
badd +1 .config/kitty/kitty.conf
badd +15 .config/nvim/init.lua
badd +5 .config/nvim/lua/config/mappings.lua
badd +2 term://~/Code/dotfiles//41064:zsh
badd +0 ~/Code
badd +1 .config/nvim/lua/config/plugins/lsp/efm/init.lua
badd +41 .config/nvim/lua/config/opts.lua
badd +5 .config/nvim/lua/config/plugins/lir.lua
badd +1 .config/nvim/lua/config/plugins/init.lua
badd +0 term://~/Code/dotfiles//41064:zsh
badd +0 terminal
badd +78 term://~/Code/dotfiles//61793:zsh
badd +0 man://nvim(1)
badd +4 ~/.zshrc
badd +0 .config/nvim/plugin/packer_compiled.vim
badd +16 ~/Code/tree-sitter-pug/pg.json
badd +1 .config/nvim/lua/config/autocmd.lua
argglobal
%argdel
$argadd ~/Code
edit term://~/Code/dotfiles//41064:zsh
argglobal
balt .config/nvim/lua/config/opts.lua
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=10
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
