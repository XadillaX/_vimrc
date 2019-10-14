" Arrow key fix
if &term[:3] == 'rxvt' || &term[:4] == 'xterm' || &term[:5] == 'screen'
  inoremap <silent> <C-[>OC <RIGHT>
endif
