" Use dein for install plugin
"
" First installation:
"
" ```sh
" $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
" $ sh ./installer.sh ~/.cache/dein
" $ rm installer.sh
" ```
let g:install_log_filename = '~/.cache/dein/install.log'

let g:bundle_groups = [
  \ 'appearance',
  \ 'general',
  \ 'programming',
  \ 'themes',
  \
  \ 'languages/javascript',
  \ 'languages/json',
  \ 'languages/markdown',
  \ 'languages/typescript',
  \ 'languages/c_cpp'
\]

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" g:polyglot_disabled should declared before vim-polyglot is loaded
let g:polyglot_disabled = ['markdown']

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('wsdjeg/dein-ui.vim')

  for $bundle_group in g:bundle_groups
    source $VIMHOME/plugins/$bundle_group/index.vimrc
  endfor

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
