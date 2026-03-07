local opt = vim.opt
local g = vim.g

g.mapleader = '-'
g.maplocalleader = '-'

g.polyglot_disabled = { 'markdown' }

vim.cmd('set nocompatible')

vim.cmd('syntax enable')
vim.cmd('filetype on')
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

vim.cmd('set langmenu=zh_cn')
opt.encoding = 'utf-8'

opt.number = true
opt.wrap = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.colorcolumn = { '80', '120' }
opt.laststatus = 2
opt.showcmd = true
opt.termguicolors = true
opt.background = 'dark'

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true

opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true
opt.matchtime = 5

opt.autoread = true
opt.autochdir = true
opt.mouse = 'a'
opt.backspace = { 'indent', 'eol', 'start' }
opt.history = 400

opt.backup = false
opt.writebackup = false

opt.updatetime = 300

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevelstart = 0

opt.errorbells = false
opt.visualbell = false
vim.cmd('set t_vb=')

if vim.fn.has('termguicolors') == 1 then
  vim.cmd([[let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum']])
  vim.cmd([[let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum']])
end

vim.cmd('set t_ut=')

local term = vim.env.TERM or ''
if term:sub(1, 4) == 'rxvt' or term:sub(1, 5) == 'xterm' or term:sub(1, 6) == 'screen' then
  vim.keymap.set('i', '<C-[>OC', '<RIGHT>', { silent = true })
end
