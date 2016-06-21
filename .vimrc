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
    
    " Syntastic
    Plugin 'scrooloose/syntastic.git'

    " Python
    Plugin 'klen/python-mode'
    
    " JSON
    Plugin 'XadillaX/json-formatter.vim'
    Plugin 'elzr/vim-json'

    " Javascript
    Plugin 'othree/yajs.vim'
    Plugin 'jason0x43/vim-js-indent'
    Plugin 'othree/javascript-libraries-syntax.vim'
    Plugin 'maksimr/vim-jsbeautify'
    Plugin 'heavenshell/vim-jsdoc'

    " Typescript
    Plugin 'leafgarland/typescript-vim'

    " Nginx
    Plugin 'evanmiller/nginx-vim-syntax'

    " Frontend...
    Plugin 'othree/html5.vim'
    Plugin 'posva/vim-vue'
    Plugin 'groenewege/vim-less'
    Plugin 'digitaltoad/vim-pug'
    Plugin 'nikvdp/ejs-syntax'

    " Markdown
    Plugin 'plasticboy/vim-markdown'
    Plugin 'NBUT-Developers/extra-instant-markdown'

    " IDE...
    " Plugin 'yggdroot/indentline'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jlanzarotta/bufexplorer'
    Plugin 'zefei/vim-wintabs'
    Plugin 'bling/vim-airline'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'junegunn/vim-easy-align'
    Plugin 'Raimondi/delimitMate'
    Plugin 'vim-scripts/grep.vim'
    Plugin 'ctrlpvim/ctrlp.vim'

    " YCM
    Plugin 'Valloric/YouCompleteMe'

    " theme...
    " Plugin 'morhetz/gruvbox'
    Plugin 'w0ng/vim-hybrid'
    Plugin 'altercation/vim-colors-solarized'

call vundle#end()

" some functions
source ~/.vim/external/common.vim

" environment
let mapleader = '-'
set wildmenu

" Theme alduin
" let g:alduin_Shout_Become_Ethereal = 1
" let g:alduin_Contract_Vampirism = 0
" let g:alduin_Shout_Aura_Whisper = 1
" let g:alduin_Shout_Fire_Breath = 1
" colorscheme alduin " should use iTerm2 theme: https://github.com/AlessandroYorba/Alduin
" set t_ut=

" Theme Hybrid
" set background=dark
" colorscheme hybrid
" " let g:hybrid_custom_term_colors = 1
" " let g:hybrid_reduced_contrast = 1
" set t_ut=

" Theme solarized
syntax enable
set background=dark
colorscheme solarized
let g:solarized_contrast = 'high'
set t_ut=

set history=400
set autoindent
set cindent
set smartindent

set autoread
set autochdir
set incsearch
set hlsearch
set showmatch
set matchtime=5
set nobackup
set mouse=a
set cursorline

" folding
set foldmethod=syntax
set foldlevelstart=0

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
    if !has('nvim')
        set encoding=utf-8
        set fileencoding=utf-8
    endif

    if has('win32') || has('win64')
        language english
        let &termencoding=&encoding
    endif

    if !has('nvim')
        set lm=zh_cn.utf-8
        let $LANG='zh_cn'
        set fencs=ucs-bom,utf-8,gbk,cp836,latin1
        set formatoptions+=mM
    endif

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
source $VIMHOME/external/ctrlp.vim
source $VIMHOME/external/hexo.vim
source $VIMHOME/external/indentline.vim
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
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <leader>/ :set nohlsearch<cr>

if has('nvim')
  nnoremap <silent> <BS> <C-w>h
endif
