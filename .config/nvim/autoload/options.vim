function! options#Init() 
    set encoding=utf-8

    set t_Co=256

    set t_8b=^[[48;2;%lu;%lu;%lum
    set t_8f=^[[38;2;%lu;%lu;%lum

    set clipboard=unnamed
    set termguicolors
    set cursorline
    set hidden
    set exrc
    set secure
    set relativenumber
    set number
    set nobackup
    set noswapfile
    set shortmess+=c
    set nowritebackup
    set ignorecase
    set smartcase
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set updatetime=300
    set background=dark
    set shell=$SHELL
    set signcolumn=yes
    set incsearch
    set nohlsearch
    set list
    set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮
    set lazyredraw
    set wrap

    syntax enable

    if has('persistent_undo')
	set undofile
	set undodir=$HOME/.vim/undo
    endif
endfunction
