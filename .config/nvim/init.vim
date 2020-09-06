" cSpell:disable 

scriptencoding utf-8
call options#Init()

call plug#begin('~/.vim/plugged')
Plug 'Asheq/close-buffers.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call config#coc#Init()

Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call config#fzf#Init()

Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
call config#dirvish#Init()

Plug 'justinmk/vim-sneak'
call config#sneak#Init()

Plug 'kristijanhusak/vim-dirvish-git'
Plug 'ekalinin/Dockerfile.vim'
Plug 'aserebryakov/vim-todo-lists'

Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
call config#lightline#Init()

Plug 'tpope/vim-dispatch'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0

Plug 'neovim/nvim-lspconfig'

Plug 'Nauticus/gruvbox'
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection=0

Plug 'sheerun/vim-polyglot'
call plug#end()

colo gruvbox

let mapleader = ' '

let g:pumheight = 8
let g:snips_author = "Emanuil Ganchev"

nnoremap <SPACE> <Nop>
map <F2> :w<CR>
nmap <leader>; :Files<CR>
nmap <leader>wr :vertical resize 127<CR>
nmap <leader>hh :History<CR>
nmap <leader>md <Plug>MarkdownPreviewToggle
nmap <leader>yl :let @* = escape(expand("%:t:r"), '/')<CR>
nmap <leader>yf :let @* = expand("%")<CR>
nmap <leader>yp :let @* = expand("%") . ':' . line(".") . ' at ' . FugitiveConfigGet('remote.origin.url') . ':' . FugitiveHead()<CR>
nmap <leader>rg :Rg <C-R>*<CR><CR>
nnoremap § :Buffers<CR>
nnoremap <silent> <leader><leader> :Files <C-R>=expand('%:h')<CR><CR>

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

