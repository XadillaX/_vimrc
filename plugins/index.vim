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

" g:polyglot_disabled should declared before vim-polyglot is loaded
let g:polyglot_disabled = ['markdown']

" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set dein base path (required)
let s:dein_base = '~/.cache/dein/'

" Set dein source path (required)
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set dein runtime path (required)
execute 'set runtimepath+=' .. s:dein_src

" Call dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)
call dein#add('wsdjeg/dein-ui.vim')

for $bundle_group in g:bundle_groups
  source $VIMHOME/plugins/$bundle_group/index.vimrc
endfor

" Finish dein initialization (required)
call dein#end()
call dein#save_state()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
if has('syntax')
  syntax on
endif
