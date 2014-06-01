set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"""""""""""""
" 个性化设置
"""""""""""""
filetype on
filetype plugin on
filetype indent on
syntax on
" set rnu nu
set wrap                                        " 自动换行
set number                                      " 显示行号
set nobackup                                    " 关闭备份
set expandtab
set smarttab
set showmatch
set matchtime=1
" set fdm=indent
set cindent
set cursorline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tags=tags;
set autochdir
set encoding=utf-8
set fileencoding=utf-8
let $LANG="zh_tw"
if has("gui_running")
    colo molokai
else
    colo vividchalk
endif
set showcmd                                         " 状态栏显示目前所执行的命令
"禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowNavVim=1

"""""""""""""""
" 一些项目路径
"""""""""""""""
if has("win32")
    let g:nodeProjectPath="D:\\CODE\\node.js"
    let g:hexoProjectPath="E:\\cygwin\\home\\XadillaX\\hexo"
else
    let g:nodeProjectPath="~/node/"
endif

fun! OpenNodeProjPath()
    execute "cd " . g:nodeProjectPath
endfun

fun! OpenHexoProjPath()
    execute "cd " . g:hexoProjectPath
endfun

" 默认不显示菜单栏，按F2又显示
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

""""""""""""""
" 键映射
""""""""""""""
let mapleader = "-"                                 " 功能键前缀
map <space> viw                                     " 空格键选中整个单词
nnoremap <leader>ev :e $MYVIMRC<cr>                 " 前缀 + e + v 打开 .vimrc 文件
nnoremap <leader>sv :source $MYVIMRC<cr>            " 前缀 + s + v 使得 .vimrc 文件即时生效
nnoremap <leader>" viw<esc>i"<esc>hbi"<esc>lel      " 把某个单词用双引号括起来
nnoremap <leader>' viw<esc>i'<esc>hbi'<esc>lel      " 用单引号
nnoremap <leader>fl :NERDTreeToggle<cr>             " 窗口管理器
nnoremap <leader>nodepath :call OpenNodeProjPath()<cr>  " 打开 node 目录
nnoremap <leader>hexopath :call OpenHexoProjPath()<cr>  " 打开 hexo 目录
nnoremap <s-h> :MBEbp<cr>                           " shift + h 前一个 tab (参照 vimium)
nnoremap <s-l> :MBEbn<cr>                           " shift + l 后一个 tab (参照 vimium)
nnoremap <leader>y "+y                              " 将选中内容拷贝到系统剪切板
nnoremap <leader>p "+p                              " 将系统剪切板粘贴到当前 vim
nnoremap <leader>hn :call OpenHexoProjPath()<cr>:!hexo new<space>
nnoremap <leader>hg :call HexoGenerate()<cr>

""""""""""""""
" Bundle
""""""""""""""
set rtp+=~/.vim/bundle/vundle.vim/
call vundle#rc()
Bundle "gmarik/vundle.vim"
Bundle "hallison/vim-markdown"
Bundle "vim-scripts/taglist.vim"
Bundle "scrooloose/nerdtree"
Bundle "vim-scripts/Tabular"
Bundle "Lokaltog/vim-powerline"
Bundle "vim-scripts/minibufexpl.vim"
Bundle "moll/vim-node"
Bundle "vim-scripts/pathogen.vim"
Bundle "walm/jshint.vim"
Bundle "tomtom/tcomment_vim"
Bundle "tpope/vim-surround"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
" ↓ dump the contents of snippets/javascript into the directory ~/.vim/snippets/javascript.
Bundle "jamescarr/snipmate-nodejs"
Bundle "ahayman/vim-nodejs-complete"

""""""""""""""
" Pathogen
""""""""""""""
call pathogen#infect()

""""""""""""""
" Power line
""""""""""""""
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'unicode'
set encoding=utf8

""""""""""""""
" 跨平台设定
""""""""""""""
if has("win32")
    set lm=zh_tw.utf-8
    set guifont=Fantasque_Sans_Mono:h11:cANSI
    set guifontwide=YouYuan:h9:cGB2312
    language C
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
else
    set guifont=CosmicSansNeueMono\ 14
endif

""""""""""""""
" 命令映射
""""""""""""""
command -nargs=+ HexoOpen :call OpenHexoPost("<args>")
command -nargs=+ HexoNew :call NewHexoPost("<args>")

""""""""""""""
" 一些自有函数
""""""""""""""
function! OpenHexoPost(...)
    call OpenHexoProjPath()

    let filename = "source/_posts/" . a:1 . ".md"
    execute "e " . filename
endfunction

function! NewHexoPost(...)
    call OpenHexoProjPath()

    let filename = a:1
    execute "!hexo new " . filename

    call OpenHexoPost(a:1)
endfunction

function! HexoGenerate()
    call OpenHexoProjPath()
    execute "!hexo generate"
endfunction

""""""""""""""
" 一些自启动
""""""""""""""
autocmd VimEnter * call OpenNodeProjPath()
autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif

