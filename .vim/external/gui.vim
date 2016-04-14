set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

if has('gui_running')
    " show menu only
    set guioptions=mcr
    
    if has('win32') || has('win64')
        source $VIMRUNTIME/mswin.vim
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim

        map <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>

        set guifont=Fantasque_Sans_mono:h11:cANSI
        set guifontwide=幼圆:h9:cGB2312
    endif

    if has('unix') && !has('gui_macvim')
        set guifont=Fantasque\ Sans\ Mono\ Regular:h14
        set guifontwidth=YaHei\ Consolas\ Hybrid\ 14
    endif

    if has('mac') || has('gui_macvim')
        set guifont=Fantasque\ Sans\ Mono:h14
        set guifontwide=WenyueType\ GutiFangsong\ \(Noncommercial\ Use\):h14

        if has('gui_macvim')
            set transparency=4
            let s:lines=&lines
            let s:columns=&columns

            func! FullScreenEnter()
                set lines=999 columns=999
                set fu
            endf

            func! FullScreenLeave()
                let &lines=s:lines
                let &columns=s:columns
                set nofu
            endf

            func! FullScreenToggle()
                if &fullscreen
                    call FullScreenLeave()
                else
                    call FullScreenEnter()
                endif
            endf
        endif
    endif
endif
