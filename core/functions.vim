function! HasConfig(file, dir)
  return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endfunction
