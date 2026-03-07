local platform = require('config.platform')

local startify_icon_vim = ''
local startify_icon_update = ''
local startify_icon_vulkan = ''
local startify_icon_love = ''
local startify_icon_link = ''
local startify_icon_github = ''
local startify_icon_key = ''
local startify_icon_watch = ''
local startify_icon_color = ''
local startify_icon_airline = ''
local startify_icon_font = ''
local startify_icon_fontsize = ''
local startify_icon_server = ''

local function platform_icon_string()
  local platform_icon = ''
  local platform_string = ''

  if platform.is_windows() then
    platform_icon = ''
    platform_string = platform.win_version() .. ' (NT ' .. platform.nt_version() .. ')'
  elseif platform.is_macos() then
    platform_icon = ''
    platform_string = 'macOS ' .. platform.osx_version() .. ' (Darwin ' .. platform.kernel_version() .. ')'
  elseif platform.is_bsd() then
    platform_icon = ''
    platform_string = platform.bsd_distro() .. ' (' .. platform.kernel_version() .. ')'
  elseif platform.is_linux() then
    local distro = platform.distro()
    if distro:match('Arch') then platform_icon = ''
    elseif distro:match('CentOS') then platform_icon = ''
    elseif distro:match('Debian') then platform_icon = ''
    elseif distro:match('Fedora') then platform_icon = ''
    elseif distro:match('Mint') then platform_icon = ''
    elseif distro:match('SUSE') then platform_icon = ''
    elseif distro:match('Ubuntu') then platform_icon = ''
    elseif distro:match('Gentoo') then platform_icon = ''
    elseif distro:match('Elementary') then platform_icon = ''
    else platform_icon = ''
    end
    platform_string = 'Linux [' .. platform.distro_version() .. '] (' .. platform.kernel_version() .. ')'

    if platform.is_wsl() then
      platform_icon = ''
      platform_string = 'WSL [' .. platform.distro_version() .. ' on Windows 10]'
    elseif platform.is_cros() then
      platform_icon = ''
      platform_string = 'Chrome OS [' .. platform.distro_version() .. ' with Chronos]'
    elseif platform.is_android() then
      platform_icon = ''
      platform_string = 'Android'
    end
  else
    platform_icon = ''
    platform_string = 'UNIX'
  end

  return platform_icon .. ' ' .. platform_string
end

local function boxed_header(line)
  local width = vim.fn.strwidth(line)
  if width <= 62 then
    return '|| ' .. line .. string.rep(' ', 62 - width) .. '||'
  else
    return '|| ' .. line:sub(1, 62) .. '||'
  end
end

vim.cmd('hi link StartifyHeader Function')

local startify_vim_version = ''
local startify_platform_string = platform_icon_string()
local startify_vim_components = '{' ..
  (vim.fn.has('python3') == 1 and '+Python3' or '-Python3') .. '|' ..
  (vim.fn.has('python') == 1 and '+Python' or '-Python') .. '|' ..
  (vim.fn.has('lua') == 1 and '+Lua' or '-Lua') .. '|' ..
  (vim.fn.has('clipboard') == 1 and '+Clip' or '-Clip') ..
  '}'

vim.g.startify_custom_header = {
  '      ____  _               _             ___               _       _  ',
  '     (  __)( )             ( )           /  _)             ( )     ( ) ',
  '     | |_  | | ___  ____  _| | __  ___   \\_"-.  __ ___  __ | | ___ | | ',
  '     ( __) ( )( o )( __ )/ o )( _)( o_)   __) )/ /( o )( _)( )( o_)( _)',
  '     /_\\   /_\\/_^_\\/_\\/_\\\\___\\/_\\  \\(    /___/ \\_\\/_^_\\/_\\ /_\\ \\(  /_\\ ',
  '                                                                       ',
  '     ||===============================================================||',
  '     ' .. boxed_header(startify_icon_vulkan .. " XadillaX' Vimrc. (๑•̀ㅂ•́)و✧"),
  '     ' .. boxed_header(startify_icon_github .. ' Github Repository: https://github.com/XadillaX/_vimrc'),
  '     ||---------------------------------------------------------------||',
  '     ' .. boxed_header('今天也要加油鸭 🦆！'),
  '     ||---------------------------------------------------------------||',
  '     ' .. boxed_header(startify_vim_version .. ' ' .. startify_vim_components),
  '     ' .. boxed_header(startify_platform_string),
  '     ' .. boxed_header(startify_icon_key .. ' Leader Key: `' .. vim.g.mapleader .. '` | Leader Guide: <Space>'),
  '     ||===============================================================||',
}

vim.g.startify_list_order = {
  { '   [MRU] in current directory:' },
  'dir',
  { '   [MRU] Most Recently Used files:' },
  'files',
  { '   [CMD] Common Commands:' },
  'commands',
  { '   Sessions:' },
  'sessions',
  { '   Bookmarks:' },
  'bookmarks',
}

vim.g.startify_commands = {
  { f = { 'File List Tree', 'NvimTreeToggle' } },
  { u = { 'Update Plugins', 'Lazy update' } },
}

if platform.is_nvim() then
  table.insert(vim.g.startify_commands, { t = { 'Open Terminal', 'terminal' } })
end
