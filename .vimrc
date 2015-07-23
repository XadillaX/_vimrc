" 设置菜单语言
set langmenu=zh_cn

"=============
" Bundle
"=============
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle "gmarik/Vundle.vim"
" 好玩的
Bundle "mattn/flappyvird-vim"
" Clojure 相关插件
Bundle "guns/vim-clojure-static"
Bundle "tpope/vim-fireplace"
Bundle "guns/vim-clojure-highlight"
Bundle "spinningarrow/vim-niji"
" Python 相关
Bundle "klen/python-mode.git"
" C++ 相关
Bundle "XadillaX/c.vim"
Bundle "Valloric/YouCompleteMe"
" HBS 相关
Bundle "mustache/vim-mustache-handlebars"
" EJS 相关
Bundle "briancollins/vim-jst"
" JS 相关
Bundle "sidorares/node-vim-debugger"
Bundle "walm/jshint.vim"
Bundle "moll/vim-node"
Bundle "heavenshell/vim-jsdoc"
Bundle "pangloss/vim-javascript"
Bundle "maksimr/vim-jsbeautify.git"
Bundle "einars/js-beautify"
Bundle "scrooloose/syntastic.git"
Bundle "mxw/vim-jsx"
" Rust
Bundle "rust-lang/rust.vim"
Bundle "cespare/vim-toml"
" JSON 相关
Bundle "elzr/vim-json"
Bundle "XadillaX/json-formatter.vim"
" 通用插件
Bundle "vim-scripts/grep.vim"
Bundle "rosenfeld/conque-term"
Bundle "fholgado/minibufexpl.vim"
Bundle "scrooloose/nerdtree"
Bundle "jistr/vim-nerdtree-tabs"
Bundle "scrooloose/nerdcommenter"
Bundle "bling/vim-airline"
Bundle "tpope/vim-fugitive"
Bundle "airblade/vim-gitgutter"
Bundle "vim-scripts/TagHighlight"
Bundle "vim-scripts/vimwiki"
Bundle "vim-scripts/taglist.vim"
Bundle "Raimondi/delimitMate"
Bundle "mileszs/ack.vim"
Bundle "godlygeek/tabular"
Bundle "junegunn/vim-easy-align"
" Markdown
Bundle "plasticboy/vim-markdown"
Bundle "suan/vim-instant-markdown"
" others
Bundle "mattn/emmet-vim"
Bundle "wavded/vim-stylus"
" Theme
Bundle "morhetz/gruvbox"
Bundle "wellsjo/wells-colorscheme.vim"
" Dash
Bundle "rizzatti/dash.vim"

"============
" 环境配置
"============
" 保留历史记录
set history=400

" 高亮配色
colorscheme onedark
set background=dark
set t_ut=

" 命令行处于状态行
set ch=1
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]\ %l,%c\ %=\ %P   
set ls=2                                                                        " 始终显示状态行

" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 状态栏显示目前所执行的命令
set showcmd

" 行控制
set nocompatible
set wrap

" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" 控制台响铃
:set noerrorbells
:set novisualbell
:set t_vb=                                                                      " close visual bell

" 在插入模式下使用 <BS>, <Del> <C-W> <C-U>
set backspace=indent,eol,start

" 命令补全菜单
set wildmenu

" 缩进
set autoindent
set cindent
set smartindent

" 自动重新读入
set autoread

" 代码折叠
set foldmethod=syntax

" 自动切换到文件当前目录
set autochdir

set incsearch
set hlsearch

" 显示匹配的括号
set showmatch
set matchtime=5

" 实现全能补全功能，需要打开文件类型检测
" 所以打开文件类型自动检测
filetype on
filetype plugin on
filetype indent on
syntax on

" 关闭备份
set nobackup

" 在所有模式下都允许鼠标
set mouse=a

" 当前航
set cursorline

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 80 列辅助线
set cc=80
set cc+=120

" =====================
" 多语言环境
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    set fileencoding=utf-8

    if has("win32")
        language english
        let &termencoding=&encoding
    endif

    set lm=zh_cn.utf-8
    let $LANG="zh_cn"
    set fencs=ucs-bom,utf-8,gbk,cp936,latin1
    set formatoptions+=mM

    " 不使用 utf8 签名
    set nobomb

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" =====================
" 图形界面
" =====================
if has("gui_running")
    " 只显示菜单
    set guioptions=mcr
    colorscheme gruvbox
    " colorscheme wells-colorscheme

    " 高亮光标所在的行
    set cursorline

    if has("win32")
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim

        " f11 最大化
        map <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>

        " 字体配置
        set guifont=Fantasque_Sans_Mono:h11:cANSI
        set guifontwide=幼圆:h9:cGB2312
    endif

    if has("unix") && !has("gui_macvim")
        set guifont=Fantasque\ Sans\ Mono\ Regular:h14
        set guifontwide=YaHei\ Consolas\ Hybrid\ 14
    endif

    if has("mac") || has("gui_macvim")
        set guifont=Fantasque\ Sans\ Mono:h14
        set guifontwide=WenyueType\ GutiFangsong\ \(Noncommercial\ Use\):h14
        if has("gui_macvim")
            set transparency=4

            let s:lines=&lines
            let s:columns=&columns
            func! FullScreenEnter()
                set lines=999 columns=999
                set fu
            endf

            func! FullScreenLeave()
                let &lines=s:lines
                let &columns=s:columns
                set nofu
            endf

            func! FullScreenToggle()
                if &fullscreen
                    call FullScreenLeave()
                else
                    call FullScreenEnter()
                endif
            endf
        endif
    endif
endif

"==============
" 一些项目路径
"==============
if has("win32")
    let g:hexoProjectPath="E:\\cygwin\\home\\XadillaX\\hexo"
else
    let g:hexoProjectPath="~/hexo-site/"
endif

fun! OpenNodeProjPath()
    execute "cd " . g:nodeProjectPath
endfun

fun! OpenHexoProjPath()
    execute "cd " . g:hexoProjectPath
endfun

"=====================
" Win 下的配置
"=====================
if has("win32")
    call OpenNodeProjPath()
endif

"=============
" 键映射
"=============
let mapleader = "-"
" 关闭 / 打开 quickfix
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>co :copen<cr>
" JSHint
nnoremap <leader>jshint :JSHint<cr>
" 选中当前单词
map <space> viw
" 打开 vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
" 执行 vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" 用双引号括当前单词
nnoremap <leader>" viw<esc>i"<esc>hbi"<esc>lel
" 用单引号括当前单词
nnoremap <leader>' viw<esc>i'<esc>hbi'<esc>lel
nnoremap <leader>( viw<esc>i(<esc>hbi)<esc>lel
" 打开/关闭 NERDTree
nnoremap <leader>fl :NERDTreeToggle<cr>
" 打开/关闭 Tlist
nnoremap <leader>tl :TlistToggle<cr>
" 打开 hexopath
nnoremap <leader>hexopath :call OpenHexoProjPath()<cr>
" 复制系统寄存器
nnoremap <leader>y "+y
" 粘贴系统寄存器
nnoremap <leader>p "+p
" 新建 hexo 日志
nnoremap <leader>hn :call OpenHexoProjPath()<cr>:!hexo new<space>
" 生存 hexo 静态
nnoremap <leader>hg :call HexoGenerate()<cr>
nnoremap <leader><cr> a<cr><esc>k$a<cr>
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
" Ctrl-d 插入时间
imap <C-d> <C-r>=GetTimeInfo()<cr>
" 换窗口
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" 设置标签路径
nnoremap <leader>st :set tags+=./tags<cr>
" 切换标签页
nnoremap <S-j> :MBEbn<cr>
nnoremap <S-k> :MBEbp<cr>
" 关闭标签页
nnoremap <S-w> :MBEbw<cr>
" 取消搜索高亮
nnoremap <leader>/ :set nohlsearch<cr>
" tag 自动生成
nnoremap <leader>tag :!ctags -R *<cr>:TlistUpdate<cr>:call AddCurrentDirToTag()<cr>
" 打开终端
map <D-r> :ConqueTermVSplit zsh<cr>

"============
" 功能函数
"============
" 获取当前目录
func GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" 把当前目录加入 tag 目录
function! AddCurrentDirToTag()
    let tag = GetPWD() . "tags"
    execute "set tags+=" . tag
endfunction

" 打开 Hexo 的文章
function! OpenHexoPost(...)
    call OpenHexoProjPath()

    let filename = "source/_posts/" . a:1 . ".md"
    execute "e " . filename
endfunction

" 新建 Hexo 的文章
function! NewHexoPost(...)
    call OpenHexoProjPath()

    let filename = a:1
    execute "!hexo new " . filename

    call OpenHexoPost(a:1)
endfunction

" Hexo 静态文件发布
function! HexoGenerate()
    call OpenHexoProjPath()
    execute "!hexo generate"
endfunction

" 获取系统时间
func! GetTimeInfo()  
    return strftime('%Y-%m-%d %H:%M:%S')  
endfunction  

"=============
" 插件配置
"=============
" python-mode
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"
" Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = "<C-S-d>"

" Airline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" GitGutter
let g:gitgutter_sign_column_always = 1

" vimclojure
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow      = 1

" JSDoc
let g:jsdoc_allow_input_prompt     = 1

" minibufexpl
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim   = 1
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg
map <Leader>mbe :MBEOpen<cr>
map <Leader>mbc :MBEClose<cr>
map <Leader>mbt :MBEToggle<cr>

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" c.vim
let  g:C_UseTool_cmake      = 'yes' 
let  g:C_UseTool_doxygen    = 'yes' 

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 0
if has("win32")
let g:ycm_global_ycm_extra_conf = 'C:\Users\XadillaX\.vim\bundle\YouCompleteMe\third_party\ycmd\examples\.ycm_extra_conf.py'
else
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
endif
set completeopt-=preview

" Grep
nnoremap <silent> <F3> :Rgrep<CR>

" Tabular
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" syntastic
let g:syntastic_check_on_open           = 1
let g:syntastic_error_symbol            = '✗'
let g:syntastic_warning_symbol          = '!'
let g:syntastic_auto_loc_list           = 1
let g:syntastic_loc_list_height         = 5
let g:syntastic_enable_highlighting     = 0
let g:syntastic_mode_map                = { 'passive_filetypes': ['scss', 'slim'] }
" syntastic - jshintrc
let g:syntastic_javascript_checkers     = ['jshint']
let g:syntastic_javascript_jshint_args  = '--config ' . $HOME . '/.jshintrc'
let g:syntastic_javascript_jshint_exec  = '/usr/local/bin/jshint'
let g:syntastic_html_tidy_ignore_errors = [
			\ 'trimming empty <i>',
			\ 'trimming empty <span>',
			\ '<input> proprietary attribute \"autocomplete\"',
			\ 'proprietary attribute \"role\"',
			\ 'proprietary attribute \"hidden\"',
			\ 'proprietary attribute \"ng-',
			\ '<svg> is not recognized!',
            \ '<path> is not recognized!',
            \ 'discarding unexpected <path>',
			\ 'discarding unexpected <svg>',
			\ 'discarding unexpected </svg>',
			\ '<rect> is not recognized!',
			\ 'discarding unexpected <rect>'
			\ ]

" jsdoc
nmap <silent> <leader><C-l> <Plug>(jsdoc)

if has("win32")
    let g:syntastic_error_symbol = 'x'
    let g:syntastic_warning_symbol = '!'

    let g:syntastic_javascript_jshint_args = '--config ' . $HOME . '/.vim/_jshintrc'
    let g:syntastic_javascript_jshint_exec = 'jshint'
endif

" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

"=============
" 命令映射
"=============
command -nargs=+ HexoOpen :call OpenHexoPost("<args>")
command -nargs=+ HexoNew :call NewHexoPost("<args>")

" 文件模板
let g:QuickTemplatePath = $HOME.'/.vim/templates/'

"=============
" 自启动命令
"=============
" autocmd StdinReadPre * let s:std_in=1
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

" 模板
augroup templates
  au!
  " read in template files
  autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/templates/skeleton.'.expand("<afile>:e")

  " parse special text in the templates after the read
  autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" 自定义后缀
au BufNewFile,BufRead *.gyp set filetype=json
