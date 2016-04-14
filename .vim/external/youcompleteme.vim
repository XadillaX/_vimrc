let g:ycm_show_diagnostics_ui = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

if has('win32') || has('win64')
    let g:ycm_global_ycm_extra_conf = 'C:\Users\XadillaX\.vim\bundle\YouCompleteMe\third_party\ycmd\examples\.ycm_extra_conf.py'
else
    let g:ycm_global_ycm_extra_conf = $VIMHOME . '/.ycm_extra_conf.py'
endif
set completeopt-=preview
