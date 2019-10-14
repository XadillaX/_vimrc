let startify_icon_vim = ''
let startify_icon_update = ''
let startify_icon_vulkan = ''
let startify_icon_love = ''
let startify_icon_link = ''
let startify_icon_github = ''
let startify_icon_key = ''
let startify_icon_watch = ''
let startify_icon_color = ''
let startify_icon_airline = ''
let startify_icon_font = ''
let startify_icon_fontsize = ''
let startify_icon_server = ''

function! PlatformIconString()
  let platform_icon = ''
  let platform_string = ''
  if WINDOWS()
    let platform_icon = ''
    let platform_string = WINVERSION() . ' (NT ' . NTVERSION() . ')'
  elseif MACOS()
    let platform_icon = ''
    let platform_string = 'macOS ' . OSXVERSION() . ' (Darwin ' . KERNELVERSION() . ')'
  elseif BSD()
    let platform_icon = ''
    let platform_string = BSDDistro() . ' (' . KERNELVERSION() . ')'
  elseif LINUX()
      let distro = DISTRO()
      let platform_icon = distro =~ 'Arch' ? '' :
          \ distro =~ 'CentOS' ? '' :
          \ distro =~ 'Debian' ? '' :
          \ distro =~ 'Fedora' ? '' :
          \ distro =~ 'Mint' ? '' :
          \ distro =~ 'SUSE' ? '' :
          \ distro =~ 'Ubuntu' ? '' :
          \ distro =~ 'Gentoo' ? '' :
          \ distro =~ 'Elementary' ? '' :
          \ ''
      let platform_string = 'Linux ' . '[' . DISTROVERSION() . '] (' . KERNELVERSION() . ')'
      if WSL()
        let platform_icon = ''
        let platform_string = 'WSL [' . DISTROVERSION() . ' on Windows 10]'
      elseif CROS()
        let platform_icon = ''
        let platform_string = 'Chrome OS [' . DISTROVERSION() . ' with Chronos]'
      elseif ANDROID()
        let platform_icon = ''
        let platform_string = 'Android'
      endif
  else
    let platform_icon = ''
    let platform_string = 'UNIX'
  endif
  if exists('g:evervim_no_patched_fonts')
    let platform_icon = ''
  endif
  return platform_icon . ' ' . platform_string
endfunction

function! s:boxed_header(line)
  let boxed_header = ''
  if (strwidth(a:line) <= 62)
    let boxed_header = a:line . repeat(' ', 62 - strwidth(a:line))
  else
    let boxed_header = strpart(a:line, 0, 62)
  endif
  let boxed_header = '|| ' . boxed_header . '||'
  return boxed_header
endfunction

hi link StartifyHeader Function

let startify_vim_version = ''
let startify_platform_string = PlatformIconString()
let startify_vim_components = '{' .
    \ (has('python3') == 1 ? '+Python3' : '-Python3') . '|' .
    \ (has('python') == 1 ? '+Python' : '-Python') . '|' .
    \ (has('lua') == 1 ? '+Lua' : '-Lua') . '|' .
    \ (has('clipboard') == 1 ? '+Clip' : '-Clip') .
    \ '}'

let g:startify_custom_header = [
  \ '      ____  _               _             ___               _       _  ',
  \ '     (  __)( )             ( )           /  _)             ( )     ( ) ',
  \ '     | |_  | | ___  ____  _| | __  ___   \_"-.  __ ___  __ | | ___ | | ',
  \ '     ( __) ( )( o )( __ )/ o )( _)( o_)   __) )/ /( o )( _)( )( o_)( _)',
  \ '     /_\   /_\/_^_\/_\/_\\___\/_\  \(    /___/ \_\/_^_\/_\ /_\ \(  /_\ ',
  \ '                                                                       ',
  \ '     ||===============================================================||',
  \ '     ' . s:boxed_header(startify_icon_vulkan . " XadillaX' Vimrc. (๑•̀ㅂ•́)و✧"),
  \ '     ' . s:boxed_header(startify_icon_github . ' Github Repository: https://github.com/XadillaX/_vimrc'),
  \ '     ||---------------------------------------------------------------||',
  \ '     ' . s:boxed_header('今天也要加油鸭 🦆！'),
  \ '     ||---------------------------------------------------------------||',
  \ '     ' . s:boxed_header(startify_vim_version . ' ' . startify_vim_components),
  \ '     ' . s:boxed_header(startify_platform_string),
  \ '     ' . s:boxed_header(startify_icon_key . ' Leader Key: `' . mapleader . '` | Leader Guide: <Space>'),
  \ '     ||===============================================================||'
\]

let g:startify_list_order = [
            \ ['   [MRU] in current directory:'],
            \ 'dir',
            \ ['   [MRU] Most Recently Used files:'],
            \ 'files',
            \ ['   [CMD] Common Commands:'],
            \ 'commands',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ]

let g:startify_commands = [
            \ { 'f': [ 'File List Tree', 'NERDTreeToggle' ] },
            \ { 'u': [ 'Update Plugins', 'DeinUpdate' ] }
            \ ]

if NVIM()
  let g:startify_commands = g:startify_commands + [ { 't': [ 'Open Terminal', 'edit term://$SHELL | normal! i' ] } ]
endif

autocmd Filetype startify setlocal nofoldenable
