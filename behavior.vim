syntax enable

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

" tabs
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" ringbell
:set noerrorbells
:set novisualbell
" close visual bell
:set t_vb=

" use <BS>
set backspace=indent,eol,start

" Hexo
command! -nargs=+ HexoOpen :call OpenHexoPost("<args>")
command! -nargs=+ HexoNew :call NewHexoPost("<args>")

" folding
set foldmethod=syntax  
set foldlevelstart=0

" System tags
set tags+=~/.nvm/versions/node/v6.9.1/include/node/tags
set tags+=~/.nvm/versions/node/v6.9.1/lib/node_modules/nan/tags
