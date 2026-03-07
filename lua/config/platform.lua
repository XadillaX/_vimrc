local M = {}

function M.is_macos()
  return vim.fn.has('macunix') == 1
end

function M.is_linux()
  return vim.fn.has('unix') == 1 and not M.is_macos() and vim.fn.has('win32unix') == 0
end

function M.is_bsd()
  local ok, result = pcall(vim.fn.system, 'uname -s')
  return ok and result:match('BSD') ~= nil
end

function M.is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

function M.is_wsl()
  if not M.is_linux() then return false end
  local ok, result = pcall(vim.fn.system, 'uname -r')
  return ok and result:match('Microsoft') ~= nil
end

function M.is_cros()
  if not M.is_linux() then return false end
  local ok, result = pcall(vim.fn.system, 'cat /proc/version')
  return ok and result:match('chrome%-bot') ~= nil
end

function M.is_android()
  return vim.fn.isdirectory('/system/priv-app') == 1
end

function M.kernel_version()
  local ok, result = pcall(vim.fn.system, 'uname -r')
  if ok then
    return result:gsub('[\n]+', '')
  end
  return ''
end

function M.distro()
  local ok, result = pcall(vim.fn.system, 'lsb_release -si')
  if ok then
    return result:gsub('[\n]+', '')
  end
  return ''
end

function M.distro_version()
  if vim.fn.executable('dpkg') == 1 then
    local ok, result = pcall(vim.fn.system, 'lsb_release -sd')
    if ok then return result:gsub('[\n"]+', '') end
  elseif M.is_cros() then
    local ok, result = pcall(vim.fn.system, 'lsb_release -sir')
    if ok then return result:gsub('[\n"]+', '') end
  else
    local ok, result = pcall(vim.fn.system, 'lsb_release -sdr')
    if ok then return result:gsub('[\n"]+', '') end
  end
  return ''
end

function M.bsd_distro()
  local ok, result = pcall(vim.fn.system, 'uname -s')
  if ok then
    return result:gsub('[\n]+', '')
  end
  return ''
end

function M.osx_version()
  local ok, result = pcall(vim.fn.system, 'sw_vers -productVersion')
  if ok then
    return result:gsub('[\n]+', '')
  end
  return ''
end

function M.nt_version()
  local ok, result = pcall(vim.fn.system, 'ver')
  if ok then
    return result:gsub('[^0-9%.]+', '')
  end
  return ''
end

function M.win_version()
  local ntversion = M.nt_version()
  if ntversion:match('4%.10') then return 'Windows 98'
  elseif ntversion:match('5%.0') then return 'Windows 2000'
  elseif ntversion:match('5%.1') then return 'Windows XP'
  elseif ntversion:match('5%.2') then return 'Windows XP x64'
  elseif ntversion:match('6%.0') then return 'Windows Vista'
  elseif ntversion:match('6%.1') then return 'Windows 7'
  elseif ntversion:match('6%.2') then return 'Windows 8'
  elseif ntversion:match('6%.3') then return 'Windows 8.1'
  elseif ntversion:match('10%.0') then return 'Windows 10'
  else return 'Windows (version unknown)'
  end
end

function M.is_nvim()
  return vim.fn.has('nvim') == 1
end

function M.is_gui()
  return vim.fn.has('gui_running') == 1 or vim.g.GuiLoaded ~= nil or vim.g.neovide ~= nil
end

function M.is_nvim_qt()
  return vim.g.GuiLoaded ~= nil
end

function M.is_nvim_gtk()
  return vim.g.GtkGuiLoaded ~= nil
end

function M.is_gonvim()
  return vim.g.gonvim_running ~= nil
end

function M.is_oni()
  return vim.g.gui_oni ~= nil
end

function M.is_vimr()
  return vim.fn.has('gui_vimr') == 1
end

function M.is_termux()
  return vim.env.TERMUX_VERSION ~= nil
end

return M
