local platform = require('config.platform')

if platform.is_gui() or vim.g.GuiLoaded then
  vim.opt.guioptions:remove('l')
  vim.opt.guioptions:remove('L')
  vim.opt.guioptions:remove('r')
  vim.opt.guioptions:remove('R')

  if platform.is_macos() or vim.fn.has('gui_macvim') == 1 then
    if platform.is_vimr() then
    else
      vim.opt.guifont = 'FantasqueSansMono Nerd Font Mono:h13'
      vim.opt.guifontwide = 'FantasqueSansMono Nerd Font Mono:h13'
    end

    vim.opt.ambiwidth = 'double'
  elseif vim.fn.has('unix') == 1 then
    if platform.is_nvim_qt() then
      vim.cmd([[GuiFont! FantasqueSansMono\ Nerd\ Font\ Mono:h13]])
      vim.opt.mouse = 'a'
      vim.cmd('GuiTabline 0')
    end
  end
end
