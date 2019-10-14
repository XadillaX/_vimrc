function! SourceConfigsIn(dir)
  let filelist = split(globpath(a:dir, '*.vim'), '\n')
  for vimconf in filelist
      execute 'source' vimconf
  endfor
endfunction

for $bundle_group in g:bundle_groups
  call SourceConfigsIn($VIMHOME . '/plugins/' . $bundle_group)
endfor
