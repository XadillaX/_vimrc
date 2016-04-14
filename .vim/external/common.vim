" some path
if has('win32') || has('win64')
    let g:hexo_project_path='E:\\cygwin\\home\\XadillaX\\hexo'
else
    let g:hexo_project_path='~/hexo/'
endif

" has config
func! HasConfig(file, dir)
    return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endf

" get current path
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" open hexo project path
func! OpenHexoProjPath()
    execute 'cd ' . g:hexo_project_path
endf

" open node when in windows
if has('win32') || has('win64')
    execute 'cd E:\\cygwin\\home\\XadillaX\\Workspace\\node'
endif

" open hexo
func! OpenHexoPost(...)
    call OpenHexoProjPath()
    let filename = 'source/_posts/' . a:1 . '.md'
    execute 'e ' . filename
endf

" new hexo article
func! NewHexoPost(...)
    call OpenHexoProjPath()
    let filename = a:1
    execute '!hexo new ' . filename
    call OpenHexoPost(a:1)
endf
