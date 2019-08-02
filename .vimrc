set hidden
set exrc
set secure
set autoread
set backspace=2
filetype indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set cursorline
set autoindent
set number
set nobackup
set ignorecase
set smartcase
syntax enable
set softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=750
set background=dark
set laststatus=2
set shell=/bin/sh
set signcolumn=yes
set splitright
set splitbelow
set timeoutlen=1000
set ttimeoutlen=0
set encoding=utf-8
set showcmd
set t_Co=256
set termguicolors
set nohlsearch
set smartcase
set relativenumber
set listchars=trail:·
set list

let mapleader = ' '

colorscheme solarized8

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

call plug#begin('~/.vim/plugged')
Plug 'goldfeld/vim-seek'
Plug 'zackhsi/fzf-tags'
Plug 'scrooloose/nerdcommenter'
Plug 'aserebryakov/vim-todo-lists'
Plug 'Asheq/close-buffers.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'RRethy/vim-illuminate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'lifepillar/vim-solarized8'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
call plug#end()

let g:solarized_visibility = "normal"
let g:solarized_termcolors=16
let test#vim#term_position = "belowright"
let g:VimTodoListsMoveItems = 0
let g:user_emmet_mode='n'
let g:EasyMotion_smartcase = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 2
let g:pumheight = 8
let g:airline#extensions#coc#enabled = 1
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:indentLine_char = '│'

nnoremap <SPACE> <Nop>
nmap <leader>; :FZF<CR>
nmap <leader>hh :History<CR>
nmap <leader>nn :NERDTree %<CR>
nmap <leader>nt :NERDTreeToggle<CR>
nmap / <Plug>(incsearch-easymotion-stay)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
nmap <leader>f <Plug>(coc-format)
vmap <leader>f <Plug>(coc-format)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap § :Buffers<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
