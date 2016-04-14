" set language to zh_CN
set langmenu=zh_cn

" be improved, required - for Vundle
set nocompatible
" required - for Vundle
filetype off

" plugin settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " C
    Plugin 'XadillaX/c.vim'
    
    " YCM
    Plugin 'Valloric/YouCompleteMe'

    " Syntastic
    Plugin 'scrooloose/syntastic.git'

    " Python
    Plugin 'klen/python-mode'
    
    " JSON
    Plugin 'XadillaX/json-formatter.vim'
    Plugin 'elzr/vim-json'

    " Javascript
    Plugin 'pangloss/vim-javascript'
    Plugin 'maksimr/vim-jsbeautify'
    Plugin 'heavenshell/vim-jsdoc'

    " Markdown
    Plugin 'plasticboy/vim-markdown'
    Plugin 'greyblake/vim-preview'

    " IDE...
    Plugin 'scrooloose/nerdtree'
    Plugin 'jlanzarotta/bufexplorer'
    Plugin 'zefei/vim-wintabs'
    Plugin 'bling/vim-airline'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'junegunn/vim-easy-align'
    Plugin 'vim-scripts/grep.vim'

    " theme...
    Plugin 'morhetz/gruvbox'

call vundle#end()

" some functions
source ~/.vim/external/common.vim

" environment
let mapleader = '-'
colorscheme gruvbox
set background=dark
set wildmenu
set t_ut=

set history=400
set autoindent
set cindent
set smartindent

set autoread
set foldmethod=syntax
set autochdir
set incsearch
set hlsearch
set showmatch
set matchtime=5
set nobackup
set mouse=a
set cursorline

"" 80 / 120 columns
set cc=80
set cc+=120

"" show status line anyway
set ls=2

"" show current command
set showcmd

"" tabs
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

"" line control
set wrap
set number

"" ringbell
:set noerrorbells
:set novisualbell
""" close visual bell
:set t_vb=

"" use <BS>
set backspace=indent,eol,start

"" multi-byte
if has("multi_byte")
    set encoding=utf-8
    set fileencoding=utf-8
    if has('win32')
        language english
        let &termencoding=&encoding
    endif

    set lm=zh_cn.utf-8
    let $LANG='zh_cn'
    set fencs=ucs-bom,utf-8,gbk,cp836,latin1
    set formatoptions+=mM

    set nobomb

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr 'Sorry, this version of (g)vim was not compiled with +multi_byte'
endif

" external files
if has('win32') || has('win64')
    let $VIMHOME = $VIM.'/vimfiles'
else
    let $VIMHOME = $HOME.'/.vim'
endif

source $VIMHOME/external/filetype.vim
source $VIMHOME/external/gui.vim

source $VIMHOME/external/airline.vim
source $VIMHOME/external/c.vim
source $VIMHOME/external/hexo.vim
source $VIMHOME/external/jsbeautify.vim
source $VIMHOME/external/jsdoc.vim
source $VIMHOME/external/markdown.vim
source $VIMHOME/external/nerdtree.vim
source $VIMHOME/external/python-mode.vim
source $VIMHOME/external/skeleton.vim
source $VIMHOME/external/syntastic.vim
source $VIMHOME/external/vim-easy-align.vim
source $VIMHOME/external/wintabs.vim
source $VIMHOME/external/youcompleteme.vim

" custom file type
au BufNewFile,BufRead *.gyp set filetype=json

" keymap
"" open / close quickfix
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>co :copen<cr>
"" select current word
map <space> viw
"" open / source vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"" hexo
nnoremap <leader>hexo :call OpenHexoProjPath()<cr>
nnoremap <leader>y "+y
nnoremap <leader>p "+p
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
nnoremap <leader>/ :set nohlsearch<cr>
