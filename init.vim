" set language to zh_CN
set langmenu=zh_cn
set encoding=utf8

if has('win32') || has('win64')
  " TODO: $VIMHOME under M$ Windows
elseif has('nvim')
  " $VIMHOME of NeoVIM
  let $VIMHOME = $HOME . '/.config/nvim'
else
  " $VIMHOME of VIM 7.*
  let $VIMHOME = $HOME . '/.vim'
endif

" load functions
source $VIMHOME/functional.vim

" load global keymaps
source $VIMHOME/keymap.vim

" plugin map
source $VIMHOME/plugin.vim

" behavior setting
source $VIMHOME/behavior.vim
source $VIMHOME/language.vim

" display information
source $VIMHOME/theme.vim
source $VIMHOME/display.vim

" some setttings
set history=400
set autoindent
set cindent
set smartindent

" project specifiec .vimrc files
set exrc
set secure
