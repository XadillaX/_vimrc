filetype off

" plugins map
call plug#begin('~/.config/nvim/bundle')
  " theme
  Plug 'mhartington/oceanic-next'

  Plug 'mhinz/vim-startify'

  " {{ INTEGRATED DEVELOPMENT ENVIRONMENT  }}
  " =========================================

  """ functional
  " Automatic completion
  Plug 'Valloric/YouCompleteMe', { 'do': 'proxychains4 ./install.py --clang-completer --tern-completer' }
  " Automatic completion configuration generator
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
  " Multiple cursors
  Plug 'terryma/vim-multiple-cursors'
  " Syntax Checking
  Plug 'scrooloose/syntastic'
  "-- Plug 'SirVer/ultisnips'
  " Quickly scaffold template files
  Plug 'pgilad/vim-skeletons'
  " CLI script 'ack'
  Plug 'mileszs/ack.vim', { 'do': 'brew install ack' }
  " Full path fuzzy file, buffer, mru, tag, ...
  Plug 'ctrlpvim/ctrlp.vim'
  " Insert or delete brackets, parens, quotes in pair
  Plug 'jiangmiao/auto-pairs'
  " EditorConfig
  Plug 'editorconfig/editorconfig-vim', { 'do': 'ln -s ~/.config/nvim/addon_configure/.editorconfig ~/.editorconfig \|\| true' }

  """ UI
  " Mordern buffer manager
  Plug 'zefei/vim-wintabs'
  " Tree explorer
  Plug 'scrooloose/nerdtree'
  " Extra syntax and highlight for NERDTree
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  " NERDTree showing git status
  Plug 'Xuyuanp/nerdtree-git-plugin'
  " Lean & Mean status
  Plug 'vim-airline/vim-airline'
  " Shows a git diff in the gutter
  Plug 'airblade/vim-gitgutter'
  " Git wrapper so awesome
  Plug 'tpope/vim-fugitive'
  " Adds file type glyphs/icons
  Plug 'ryanoasis/vim-devicons'

  " {{ LANGUAGES / DEVELOPMENT AREAS }}
  " ===============

  """ Web / Node.js
  "-- Plug 'jelera/vim-javascript-syntax'
  "-- Plug 'Quramy/tsuquyomi' " typescript
  " TypeScript Syntax
  Plug 'leafgarland/typescript-vim'
  " Yet another JavaScript Syntax
  Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'html' ] }
  " HTML5 omnicomplete and syntax
  Plug 'othree/html5.vim', { 'for': [ 'html' ] }
  " Syntax for JavaScript libraries
  Plug 'othree/javascript-libraries-syntax.vim'
  " Swig templeting syntax
  Plug 'blockloop/vim-swigjs',
  " Syntax Highlight for Vue.js components
  Plug 'posva/vim-vue'
  "-- Plug 'maksimr/vim-jsbeautify', { 'for': [ 'javascript', 'html', 'css' ], 'do': 'npm install --registry=https://registry.npm.taobao.org' }
  " Indenter for standalone and embedded JavaScript
  Plug 'jason0x43/vim-js-indent', { 'for': [ 'javascript', 'html'  ]  } " useful for `switch`
  " Generate JSDoc to your JavaScript code
  Plug 'heavenshell/vim-jsdoc', { 'for': [ 'javascript', 'html' ] }
  " Pug template syntax
  Plug 'digitaltoad/vim-jade'
  " Syntax Highlight for Stylus
  Plug 'wavded/vim-stylus'
  " React JSX syntax highlighting and indenting
  Plug 'mxw/vim-jsx'
  " OpenResty configuration highlight
  Plug 'hexchain/vim-openresty'
  " Highlighting and indenting JST/EJS syntax
  Plug 'briancollins/vim-jst'

  """ Lua
  "-- Plug 'xolox/vim-misc'
  "-- Plug 'xolox/vim-lua-ftplugin'
  " LÖVE syntax highlighting and help file
  Plug 'davisdude/vim-love-docs'

  """ C / CPP
  " Additional syntax highlighting for C++
  Plug 'octol/vim-cpp-enhanced-highlight'
  " Displays tags in a window
  Plug 'majutsushi/tagbar'

  """ Markdown
  " Text filtering and alignment (Tables)
  Plug 'godlygeek/tabular'
  " Markdown VIM Mode
  Plug 'plasticboy/vim-markdown'
  " Instant Markdown previews
  Plug 'NBUT-Developers/extra-instant-markdown', { 'do': 'npm install -g instant-markdown-x --registry=https://registry.npm.taobao.org', 'for': 'markdown' }

  """ TOML
  " Syntax for TOML (ini)
  Plug 'cespare/vim-toml'

  """ JSON
  " A better JSON
  Plug 'elzr/vim-json'
  " Formatting saved JSON file
  Plug 'XadillaX/json-formatter.vim', { 'do': 'npm install -g jjson --registry=https://registry.npm.taobao.org', 'for': 'json' }
call plug#end()

" external plugin settings
source $VIMHOME/external/startify.vim
source $VIMHOME/external/devicons.vim
source $VIMHOME/external/nerdtree.vim
source $VIMHOME/external/nerdtree-syntax-highlight.vim
source $VIMHOME/external/nerdtree-git.vim
source $VIMHOME/external/wintabs.vim
source $VIMHOME/external/airline.vim
source $VIMHOME/external/skeletons.vim
source $VIMHOME/external/syntastic.vim
source $VIMHOME/external/ctrlp.vim
source $VIMHOME/external/youcompleteme.vim

source $VIMHOME/external/web_nodejs/js-indent.vim
source $VIMHOME/external/web_nodejs/javascript-libraries-syntax.vim
source $VIMHOME/external/web_nodejs/jsbeautify.vim
source $VIMHOME/external/web_nodejs/jsdoc.vim
source $VIMHOME/external/web_nodejs/jsx.vim
source $VIMHOME/external/web_nodejs/openresty.vim

source $VIMHOME/external/lua/vim-lua.vim

source $VIMHOME/external/c_cpp/enhanced-highlight.vim
source $VIMHOME/external/c_cpp/tagbar.vim

source $VIMHOME/external/markdown/markdown-syntax.vim
