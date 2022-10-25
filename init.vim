" set language to zh_CN
set langmenu=zh_cn
set encoding=utf8

if has('win32') || has('win64')
  " TODO: $VIMHOME under M$ Windows
elseif has('nvim')
  " $VIMHOME of neovim
  let $VIMHOME = $HOME . '/.config/nvim'
else
  " $VIMHOME of vim
  let $VIMHOME = $HOME . '/.vim'
endif

source $VIMHOME/core/core.vim
