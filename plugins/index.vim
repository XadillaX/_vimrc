" Use dein for install plugin
"
" First installation:
"
" ```sh
" $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
" $ sh ./installer.sh ~/.cache/dein
" $ rm installer.sh
" ```
let g:bundle_groups = [
  \ 'appearance',
  \ 'general',
  \ 'programming',
  \ 'themes',
  \ 'youcompleteme',
  \
  \ 'languages/javascript',
  \ 'languages/json',
  \ 'languages/markdown',
  \ 'languages/typescript'
\]

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

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
