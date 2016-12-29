filetype off

" plugins map
call plug#begin('~/.config/nvim/bundle')
  Plug 'mhinz/vim-startify'

  " {{ INTEGRATED DEVELOPMENT ENVIRONMENT  }}
  " =========================================

  " functional
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
  Plug 'terryma/vim-multiple-cursors'
  Plug 'scrooloose/syntastic', { 'do': [ 'npm install -g nan --registry=https://registry.npm.taobao.org',
              \'ln -s ~/.config/nvim/addon_configure/.jshintrc ~/.jshintrc \|\| true',
              \'ln -s ~/.config/nvim/addon_configure/.tern-project ~/.tern-config \|\| true' ] }
  Plug 'SirVer/ultisnips'
  Plug 'pgilad/vim-skeletons'
  Plug 'mileszs/ack.vim', { 'do': 'brew install ack' }
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'editorconfig/editorconfig-vim', { 'do': 'ln -s ~/.config/nvim/addon_configure/.editorconfig ~/.editorconfig \|\| true' }

  " UI
  Plug 'zefei/vim-wintabs'
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'vim-airline/vim-airline'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'ryanoasis/vim-devicons'

  " theme
  Plug 'mhartington/oceanic-next'

  " {{ LANGUAGES / DEVELOPMENT AREAS }}
  " ===============

  " Web / Node.js
  Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'html' ] }
  Plug 'othree/html5.vim', { 'for': [ 'html' ] }
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'maksimr/vim-jsbeautify', { 'for': [ 'javascript', 'html', 'css' ], 'do': 'npm install --registry=https://registry.npm.taobao.org' }
  " useful for `switch`
  Plug 'jason0x43/vim-js-indent', { 'for': [ 'javascript', 'html'  ]  }
  Plug 'heavenshell/vim-jsdoc', { 'for': [ 'javascript', 'html' ] }
  Plug 'digitaltoad/vim-jade'
  Plug 'wavded/vim-stylus'

  " C / CPP
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'majutsushi/tagbar'

  " Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'NBUT-Developers/extra-instant-markdown', { 'do': 'npm install -g instant-markdown-x --registry=https://registry.npm.taoba.org', 'for': 'markdown' }

  " TOML
  Plug 'cespare/vim-toml'

  " JSON
  Plug 'elzr/vim-json'
  Plug 'XadillaX/json-formatter.vim'
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

source $VIMHOME/external/c_cpp/enhanced-highlight.vim
source $VIMHOME/external/c_cpp/tagbar.vim

source $VIMHOME/external/markdown/markdown-syntax.vim
