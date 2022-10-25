let g:lightline = {}
let g:lightline.colorscheme = 'sonokai'
let g:vim_lightline_artify = 2

" https://github.com/sainnhe/dotfiles/blob/0deab24ca971a6c226e54793285f0a194878de96/.config/nvim/autoload/custom/lightline.vim
function plugins#appearance#lightline#coc_diagnostic_error() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'error', 0) ==# 0 ? '' : "\uf00d" . info['error']
endfunction "}}}

function plugins#appearance#lightline#coc_diagnostic_warning() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'warning', 0) ==# 0 ? '' : "\uf529" . info['warning']
endfunction "}}}

function plugins#appearance#lightline#coc_diagnostic_ok() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0) ==# 0 && get(info, 'error', 0) ==# 0
    let msg = "\uf00c"
  else
    let msg = ''
  endif
  return msg
endfunction "}}}

function plugins#appearance#lightline#coc_status() abort "{{{
  return get(g:, 'coc_status', '')
endfunction "}}}

function plugins#appearance#lightline#git_global() abort "{{{
  let git_status = get(g:, 'coc_git_status', '')
  if git_status ==# ''
    if g:vim_lightline_artify ==# 2
      let status = ' ' . artify#convert(fnamemodify(getcwd(), ':t'), 'monospace')
    else
      let status = ' ' . fnamemodify(getcwd(), ':t')
    endif
  else
    if g:vim_lightline_artify ==# 2
      let status = artify#convert(git_status, 'monospace')
    else
      let status = git_status
    endif
  endif
  return status
endfunction "}}}

function plugins#appearance#lightline#devicons() "{{{
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction "}}}

function plugins#appearance#lightline#tabnum(n) abort "{{{
  return a:n." \ue0bb"
endfunction "}}}

function plugins#appearance#lightline#artify_active_tabnum(n) abort "{{{
  return artify#convert(a:n, 'bold')." \ue0bb"
endfunction "}}}

function plugins#appearance#lightline#artify_inactive_tabnum(n) abort "{{{
  return artify#convert(a:n, 'double_struck')." \ue0bb"
endfunction "}}}

function plugins#appearance#lightline#artify_tabname(s) abort "{{{
  if g:vim_lightline_artify ==# 2
    return artify#convert(lightline#tab#filename(a:s), 'monospace')
  else
    return lightline#tab#filename(a:s)
  endif
endfunction "}}}

function plugins#appearance#lightline#artify_mode() abort "{{{
  if g:vim_lightline_artify ==# 2
    return artify#convert(lightline#mode(), 'monospace')
  else
    return lightline#mode()
  endif
endfunction "}}}

function plugins#appearance#lightline#artify_line_percent() abort "{{{
  return artify#convert(string((100*line('.'))/line('$')), 'bold')
endfunction "}}}

function plugins#appearance#lightline#artify_line_num() abort "{{{
  return artify#convert(string(line('.')), 'bold')
endfunction "}}}

function plugins#appearance#lightline#artify_column_num() abort "{{{
  return artify#convert(string(getcurpos()[2]), 'bold')
endfunction "}}}

" https://github.com/sainnhe/dotfiles/blob/0deab24ca971a6c226e54793285f0a194878de96/.config/nvim/features/full.vim#L10-L97

let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline#asyncrun#indicator_none = ''
let g:lightline#asyncrun#indicator_run = 'Running...'

if g:vim_lightline_artify == 0
  let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'git_global' ],
        \ [ 'git_buffer' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'tabnum', 'filename', 'modified' ],
        \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
else
  let g:lightline.active = {
        \ 'left': [ [ 'artify_mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'artify_lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'artify_lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'git_global' ],
        \ [ 'git_buffer' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'artify_activetabnum', 'artify_filename', 'modified' ],
        \ 'inactive': [ 'artify_inactivetabnum', 'filename', 'modified' ] }
endif

let g:lightline.tab_component_function = {
      \ 'artify_activetabnum': 'plugins#appearance#lightline#artify_active_tabnum',
      \ 'artify_inactivetabnum': 'plugins#appearance#lightline#artify_inactive_tabnum',
      \ 'artify_filename': 'plugins#appearance#lightline#artify_tabname',
      \ 'tabnum': 'plugins#appearance#lightline#tabnum',
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly'
      \ }
let g:lightline.component = {
      \ 'git_buffer' : '%{get(b:, "coc_git_status", "")}',
      \ 'git_global' : '%{plugins#appearance#lightline#git_global()}',
      \ 'artify_mode': '%{plugins#appearance#lightline#artify_mode()}',
      \ 'artify_lineinfo': "%2{plugins#appearance#lightline#artify_line_percent()}\uf295 %3{plugins#appearance#lightline#artify_line_num()}:%-2{plugins#appearance#lightline#artify_column_num()}",
      \ 'vim_logo': "\ue7c5",
      \ 'mode': '%{lightline#mode()}',
      \ 'filename': '%t',
      \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
      \ 'modified': '%M',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'lineinfo': '%2p%% %3l:%-2v'
      \ }
let g:lightline.component_function = {
      \ 'devicons_filetype': 'plugins#appearance#lightline#devicons',
      \ 'coc_status': 'plugins#appearance#lightline#coc_status'
      \ }
let g:lightline.component_expand = {
      \ 'linter_warnings': 'plugins#appearance#lightline#coc_diagnostic_warning',
      \ 'linter_errors': 'plugins#appearance#lightline#coc_diagnostic_error',
      \ 'linter_ok': 'plugins#appearance#lightline#coc_diagnostic_ok',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
