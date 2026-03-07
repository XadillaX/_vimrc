function! lightline#custom#coc_diagnostic_error() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'error', 0) ==# 0 ? '' : "\uf00d" . info['error']
endfunction

function! lightline#custom#coc_diagnostic_warning() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'warning', 0) ==# 0 ? '' : "\uf529" . info['warning']
endfunction

function! lightline#custom#coc_diagnostic_ok() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0) ==# 0 && get(info, 'error', 0) ==# 0
    let msg = "\uf00c"
  else
    let msg = ''
  endif
  return msg
endfunction

function! lightline#custom#coc_status() abort
  return get(g:, 'coc_status', '')
endfunction

function! lightline#custom#git_global() abort
  let git_status = get(g:, 'coc_git_status', '')
  if git_status ==# ''
    if g:vim_lightline_artify ==# 2
      let status = ' ' . artify#convert(fnamemodify(getcwd(), ':t'), 'monospace')
    else
      let status = ' ' . fnamemodify(getcwd(), ':t')
    endif
  else
    if g:vim_lightline_artify ==# 2
      let status = artify#convert(git_status, 'monospace')
    else
      let status = git_status
    endif
  endif
  return status
endfunction

function! lightline#custom#devicons()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! lightline#custom#tabnum(n) abort
  return a:n." \ue0bb"
endfunction

function! lightline#custom#artify_active_tabnum(n) abort
  return artify#convert(a:n, 'bold')." \ue0bb"
endfunction

function! lightline#custom#artify_inactive_tabnum(n) abort
  return artify#convert(a:n, 'double_struck')." \ue0bb"
endfunction

function! lightline#custom#artify_tabname(s) abort
  if g:vim_lightline_artify ==# 2
    return artify#convert(lightline#tab#filename(a:s), 'monospace')
  else
    return lightline#tab#filename(a:s)
  endif
endfunction

function! lightline#custom#artify_mode() abort
  if g:vim_lightline_artify ==# 2
    return artify#convert(lightline#mode(), 'monospace')
  else
    return lightline#mode()
  endif
endfunction

function! lightline#custom#artify_line_percent() abort
  return artify#convert(string((100*line('.'))/line('$')), 'bold')
endfunction

function! lightline#custom#artify_line_num() abort
  return artify#convert(string(line('.')), 'bold')
endfunction

function! lightline#custom#artify_column_num() abort
  return artify#convert(string(getcurpos()[2]), 'bold')
endfunction
