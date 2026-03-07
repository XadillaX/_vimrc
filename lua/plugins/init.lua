local plugins = {}
local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'
local all_config_modules = {}

local function scan_dir(dir)
  local items = {}
  local handle = vim.loop.fs_scandir(dir)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == 'directory' and name ~= '.' and name ~= '..' then
        table.insert(items, name)
      end
    end
  end
  table.sort(items)
  return items
end

local function scan_lua_files(dir, module_prefix)
  local files = {}
  local handle = vim.loop.fs_scandir(dir)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == 'file' and name:match('%.lua$') and name ~= 'init.lua' then
        table.insert(files, module_prefix .. '.' .. name:gsub('%.lua$', ''))
      end
    end
  end
  return files
end

local function load_category(module_path, dir)
  local ok, category_plugins = pcall(require, module_path)
  if ok and type(category_plugins) == 'table' then
    for _, plugin in ipairs(category_plugins) do
      table.insert(plugins, plugin)
    end
  end
  local config_modules = scan_lua_files(dir, module_path)
  for _, m in ipairs(config_modules) do
    table.insert(all_config_modules, m)
  end
end

local categories = scan_dir(plugins_dir)
for _, category in ipairs(categories) do
  local category_path = plugins_dir .. '/' .. category
  local init_file = category_path .. '/init.lua'
  if vim.loop.fs_stat(init_file) then
    load_category('plugins.' .. category, category_path)
  end
  local subcategories = scan_dir(category_path)
  for _, subcategory in ipairs(subcategories) do
    local sub_path = category_path .. '/' .. subcategory
    local sub_init = sub_path .. '/init.lua'
    if vim.loop.fs_stat(sub_init) then
      load_category('plugins.' .. category .. '.' .. subcategory, sub_path)
    end
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  once = true,
  callback = function()
    for _, module in ipairs(all_config_modules) do
      pcall(require, module)
    end
  end,
})

return plugins
