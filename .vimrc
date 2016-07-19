" set language to zh_CN
set langmenu=zh_cn

" be improved, required - for vim-plug
set nocompatible
" required - for vim-plug
filetype off

" plugin settings
call plug#begin('~/.vim/bundle')

    " C
    Plug 'xadillax/c.vim', { 'do': 'node ../../install_scripts/c.js' }
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'majutsushi/tagbar'
    
    " Syntastic
    Plug 'scrooloose/syntastic'

    " Python
    Plug 'klen/python-mode', { 'for': 'python' }
    
    " JSON
    Plug 'XadillaX/json-formatter.vim', { 'do': 'npm install -g jjson', 'for': 'json' }
    Plug 'elzr/vim-json', { 'for': 'json' }

    " Javascript
    Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'html', 'vue' ] }
    Plug 'jason0x43/vim-js-indent', { 'for': [ 'javascript', 'html', 'vue' ] }
    Plug 'othree/javascript-libraries-syntax.vim', { 'for': [ 'javascript', 'html', 'vue' ] }
    Plug 'maksimr/vim-jsbeautify', { 'for': [ 'javascript', 'html', 'vue', 'json', 'css' ], 'do': 'npm install' }
    Plug 'heavenshell/vim-jsdoc', { 'for': [ 'javascript', 'html', 'vue' ] }

    " Typescript
    Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

    " Nginx
    Plug 'evanmiller/nginx-vim-syntax'

    " Frontend...
    Plug 'othree/html5.vim', { 'for': 'html' }
    Plug 'posva/vim-vue', { 'for': 'vue' }
    Plug 'groenewege/vim-less', { 'for': 'less' }
    Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
    Plug 'nikvdp/ejs-syntax', { 'for': 'ejs' }

    " Markdown
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'NBUT-Developers/extra-instant-markdown', { 'for': 'markdown', 'do': 'npm -g install instant-markdown-x' }

    " IDE...
    Plug 'godlygeek/csapprox'
    Plug 'terryma/vim-multiple-cursors'
    " Plugin 'yggdroot/indentline'
    Plug 'godlygeek/tabular', { 'for': 'markdown' } " needed by plasticboy/vim-markdown
    Plug 'editorconfig/editorconfig-vim'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'zefei/vim-wintabs'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/vim-easy-align'
    Plug 'Raimondi/delimitMate'
    " Plug 'vim-scripts/grep.vim'
    Plug 'mileszs/ack.vim', { 'do': 'brew install ack' }
    Plug 'ctrlpvim/ctrlp.vim'

    " YCM
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer --racer-completer' }

    " theme...
    Plug 'morhetz/gruvbox'
    Plug 'w0ng/vim-hybrid'
    Plug 'altercation/vim-colors-solarized'

call plug#end()

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
colorscheme gruvbox
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
source $VIMHOME/external/vim-cpp-enhanced-highlight.vim
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
source $VIMHOME/external/tagbar.vim

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
