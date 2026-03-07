# Spec: Neovim 配置现代化重构

## 1. 背景与目标

### 1.1 背景

当前 Neovim 配置存在以下技术债务（详见 [audit-report.md](audit-report.md)）：

- **架构过时**：以 VimScript 为主，混合少量 Lua 代码
- **插件管理器老旧**：使用 dein.vim，缺乏现代懒加载能力
- **功能冗余**：ALE 和 CoC 同时提供诊断功能
- **代码重复**：多处重复设置（`nocompatible`、`nobackup`、`cursorline`）
- **Autocmd 风险**：未使用 augroup 包裹，重载配置时会重复注册
- **主题冗余**：安装了 17 个主题插件，仅使用 sonokai
- **快捷键冲突**：`<space>` 同时被 `viw` 和 CoC 映射使用

### 1.2 业务目标

- 将配置迁移到 lazy.nvim + Lua，提升可维护性和启动性能
- 消除审计报告中的严重问题和警告
- 保持与 vim 的基础兼容性（键位和主题）
- 保留现有的插件分类机制和自动加载能力

### 1.3 用户/涉众目标

- **配置所有者**：保持所有现有使用习惯不变，包括快捷键、功能、外观
- **跨机器同步**：支持在多台机器间同步配置
- **vim 用户**：在 vim 中保证基础键位和主题可用

## 2. 需求类型概览

| 类型 | 适用 | 来源 |
|------|------|------|
| 业务需求 | 是 | 审计报告、用户反馈 |
| 用户/涉众需求 | 是 | 用户访谈 |
| 解决方案需求 | 是 | 技术分析 |
| 功能需求 | 是 | 下文详述 |
| 非功能需求 | 是 | 性能、兼容性 |
| 外部接口需求 | 是 | vim 兼容性 |
| 过渡需求 | 是 | 迁移策略 |

## 3. 功能需求

### FR-001: 迁移到 lazy.nvim 插件管理器

- **描述**：系统必须使用 lazy.nvim 替代 dein.vim 作为插件管理器
- **验收标准**：
  - lazy.nvim 正确安装并自动引导
  - 所有现有插件（64 个）成功迁移
  - 支持懒加载（event、cmd、ft、keys 触发器）
  - `:Lazy` 命令可用于管理插件
- **优先级**：Must
- **类型映射**：解决方案/功能需求
- **来源**：审计报告 - 严重问题 #2

### FR-002: 保留插件分类机制

- **描述**：系统必须保留现有的插件分类目录结构和自动加载机制
- **验收标准**：
  - 插件按类别组织在 `lua/plugins/` 子目录中（appearance、general、programming、themes、languages/*）
  - 每个类别目录有一个 `init.lua` 声明该类插件列表
  - 插件配置文件自动加载（如果存在）
  - 禁用插件只需在数组中注释掉对应行
- **优先级**：Must
- **类型映射**：用户需求/功能需求
- **来源**：用户访谈 - 问题 #9

### FR-003: VimScript 到 Lua 迁移

- **描述**：系统必须将核心配置从 VimScript 迁移到 Lua
- **验收标准**：
  - `core/` 目录下的配置迁移到 `lua/config/`
  - 使用 `vim.opt`、`vim.o`、`vim.g` 替代 `set`、`let`
  - 使用 `vim.keymap.set` 替代 `nnoremap` 等
  - 使用 `vim.api.nvim_create_autocmd` 替代 `autocmd`
  - 所有 autocmd 必须包裹在 augroup 中
- **优先级**：Must
- **类型映射**：解决方案/功能需求
- **来源**：审计报告 - 最佳实践

### FR-004: 消除重复设置

- **描述**：系统必须消除重复的选项设置
- **验收标准**：
  - `nocompatible` 只在一处设置（或依赖 Neovim 默认值）
  - `nobackup` 只在一处设置
  - `cursorline` 只在一处设置
  - 所有全局选项统一在 `lua/config/options.lua` 中设置
- **优先级**：Must
- **类型映射**：功能需求
- **来源**：审计报告 - 警告 #1

### FR-005: 修复 Autocmd 问题

- **描述**：系统必须将所有 autocmd 包裹在 augroup 中
- **验收标准**：
  - nvim-tree 的 autocmd 使用 augroup
  - coc.nvim 的 CursorHold autocmd 使用 augroup
  - startify 的 autocmd 使用 augroup
  - 其他所有 autocmd 使用 augroup
  - 重载配置时不会重复注册 autocmd
- **优先级**：Must
- **类型映射**：功能需求
- **来源**：审计报告 - 警告 #2

### FR-006: 精简主题插件

- **描述**：系统应该精简主题插件数量
- **验收标准**：
  - 保留 sonokai（当前使用）
  - 保留 gruvbox（经典主题）
  - 保留 nord-vim（流行主题）
  - 移除其他 14 个未使用的主题
  - 主题加载顺序正确（在状态栏之前）
- **优先级**：Should
- **类型映射**：功能需求
- **来源**：审计报告 - 警告 #3、用户确认

### FR-007: 配置 ALE 与 CoC 分工

- **描述**：系统必须明确 ALE 和 CoC 的职责分工
- **验收标准**：
  - ALE 负责所有 linting（eslint、cpplint 等）
  - CoC 负责补全、LSP 功能（定义跳转、引用查找等）
  - 禁用 CoC 的诊断显示或配置不冲突
  - 诊断信息不重复显示
- **优先级**：Must
- **类型映射**：功能需求
- **来源**：审计报告 - 严重问题 #1、用户确认

### FR-008: 更新 Startify 配置

- **描述**：系统必须更新 startify 中的过时命令
- **验收标准**：
  - 将 `NERDTreeToggle` 替换为 `NvimTreeToggle`
  - 启动页功能正常
- **优先级**：Should
- **类型映射**：功能需求
- **来源**：审计报告 - 建议 #6、用户确认

### FR-009: 保持所有快捷键不变

- **描述**：系统必须保持所有现有快捷键映射不变
- **验收标准**：
  - Leader 键保持为 `-`
  - `<space>` 保持映射为 `viw`
  - CoC 的 `<space>` 前缀映射保持不变
  - 所有窗口导航快捷键（`<C-j/k/h/l>`）保持不变
  - 所有插件快捷键保持不变
- **优先级**：Must
- **类型映射**：用户需求/功能需求
- **来源**：用户访谈 - 问题 #6

### FR-010: vim 兼容性支持

- **描述**：系统必须在配置中支持 vim 的基础功能
- **验收标准**：
  - 通过 `if has('nvim')` 判断区分 nvim 和 vim
  - vim 中基础键位可用（窗口导航、leader 键等）
  - vim 中主题可用（sonokai 或降级方案）
  - vim 中不加载 nvim 专用插件
- **优先级**：Must
- **类型映射**：外部接口需求
- **来源**：用户访谈 - 问题 #1、#8

## 4. 非功能需求

### NFR-001: 启动性能

- **描述**：配置应尽可能快地启动
- **测量方式**：`nvim --startuptime` 测量，目标无硬性指标但应优于当前
- **优先级**：Should
- **来源**：用户访谈 - 问题 #7

### NFR-002: 可维护性

- **描述**：配置结构应清晰、易于维护
- **测量方式**：
  - 目录结构符合约定
  - 代码风格一致
  - 注释充分
- **优先级**：Must
- **来源**：用户访谈 - 问题 #9

### NFR-003: 跨平台兼容性

- **描述**：配置应支持 macOS、Linux
- **测量方式**：在不同平台上测试基础功能
- **优先级**：Should
- **来源**：用户访谈 - 问题 #8

## 5. 外部接口需求

### IF-001: vim 兼容接口

- **类型**：系统集成
- **入口**：`~/.vimrc` 或 `~/.config/nvim/init.vim`
- **交互**：
  - 检测 `has('nvim')` 决定加载路径
  - vim 加载精简配置（基础选项、键位、主题）
  - nvim 加载完整 Lua 配置
- **错误处理**：vim 中跳过不兼容的插件和配置
- **来源**：用户访谈

### IF-002: lazy.nvim 接口

- **类型**：插件管理器 API
- **入口**：`lua/plugins/init.lua`
- **交互**：
  - 自动引导安装 lazy.nvim
  - 扫描 `lua/plugins/*/init.lua` 加载插件 spec
  - 支持 `:Lazy` 命令
- **来源**：技术设计

## 6. 过渡需求

### TR-001: 配置备份

- **描述**：迁移前备份现有配置
- **策略**：将现有 VimScript 配置移动到 `_legacy/` 目录
- **回滚方案**：恢复 `_legacy/` 目录内容到原位置
- **来源**：风险缓解

### TR-002: 渐进迁移

- **描述**：采用渐进迁移策略，而非一次性重写
- **策略**：
  1. 先建立 Lua 框架和 lazy.nvim
  2. 逐个迁移插件配置
  3. 最后迁移核心配置
- **来源**：用户选择（选项 B）

### TR-003: dein.vim 清理

- **描述**：迁移完成后清理 dein.vim 相关文件
- **策略**：
  - 删除 `~/.cache/dein/` 目录（可选，用户手动）
  - 移除 dein.vim 相关配置代码
- **来源**：技术设计

## 7. 约束与假设

### 7.1 技术约束

- Neovim 版本：v0.10.2（支持 `vim.lsp.inlay_hint` 等新 API）
- Lua 版本：LuaJIT（Neovim 内置）
- 插件管理器：lazy.nvim（替代 dein.vim）

### 7.2 业务约束

- 必须保持所有现有功能和使用习惯
- 必须支持 vim 基础兼容性

### 7.3 假设

- 所有现有插件都有 lazy.nvim 兼容的安装方式 - 来源：已验证
- 用户熟悉 Lua 语法 - 来源：假设
- 配置仓库使用 Git 管理 - 来源：假设

## 8. 优先级与里程碑建议

| ID | 需求 | 优先级 | 原因 |
|----|------|--------|------|
| FR-001 | lazy.nvim 迁移 | Must | 核心架构变更 |
| FR-002 | 插件分类机制 | Must | 用户明确要求 |
| FR-003 | VimScript 迁移 | Must | 现代化基础 |
| FR-004 | 消除重复设置 | Must | 代码质量 |
| FR-005 | Autocmd 修复 | Must | 避免 bug |
| FR-007 | ALE/CoC 分工 | Must | 消除冲突 |
| FR-009 | 快捷键不变 | Must | 用户体验 |
| FR-010 | vim 兼容性 | Must | 用户要求 |
| FR-006 | 精简主题 | Should | 优化 |
| FR-008 | Startify 更新 | Should | 修复过时引用 |

### 里程碑建议

- **M1: 框架搭建**：建立 Lua 目录结构、lazy.nvim 引导、自动加载机制
- **M2: 插件迁移**：迁移所有 64 个插件到 lazy.nvim
- **M3: 核心迁移**：迁移 core/ 配置到 lua/config/
- **M4: 清理优化**：消除重复、修复 autocmd、精简主题
- **M5: vim 兼容**：添加 vim 兼容层

## 9. 变更/设计提案（RFC）

### 9.1 现状分析

#### 当前架构

```
~/.config/nvim/
├── init.vim                 # 入口：设置 $VIMHOME，加载 core/core.vim
├── core/
│   ├── core.vim             # 核心加载器：依次加载各模块
│   ├── arrowkey-fix.vim     # 箭头键修复
│   ├── platform.vim         # 平台检测函数（MACOS()、LINUX() 等）
│   ├── functions.vim        # 工具函数（HasConfig）
│   ├── keymap.vim           # 全局快捷键
│   ├── general.vim          # 通用设置
│   ├── gui.vim              # GUI 设置
│   ├── language.vim         # 文件类型关联
│   └── vimui.vim            # UI 设置
├── plugins/
│   ├── index.vim            # 插件入口：dein.vim 引导 + 遍历 bundle_groups
│   ├── config.vim           # 配置加载器：遍历目录加载 *.vim
│   ├── appearance/
│   │   ├── index.vimrc      # 插件声明（dein#add）
│   │   ├── lightline.vim    # lightline 配置
│   │   └── ...
│   ├── general/
│   ├── programming/
│   ├── themes/
│   └── languages/
│       ├── javascript/
│       ├── typescript/
│       └── ...
└── coc-settings.json        # CoC 配置
```

#### 当前问题

1. **dein.vim 局限**：缺乏细粒度懒加载控制
2. **VimScript 主导**：不利于利用 Neovim 的 Lua API
3. **重复设置**：`nocompatible`、`nobackup`、`cursorline` 多处设置
4. **Autocmd 风险**：未使用 augroup，重载时重复注册
5. **主题冗余**：17 个主题只用 1 个
6. **ALE/CoC 冲突**：诊断功能重叠

### 9.2 目标状态

#### 目标架构

```
~/.config/nvim/
├── init.lua                 # 入口：加载 lua/config/init.lua
├── lua/
│   ├── config/
│   │   ├── init.lua         # 配置入口：加载 options、keymaps、autocmds、lazy
│   │   ├── options.lua      # 所有 vim.opt/vim.o 设置
│   │   ├── keymaps.lua      # 所有全局快捷键
│   │   ├── autocmds.lua     # 所有 autocmd（带 augroup）
│   │   ├── lazy.lua         # lazy.nvim 引导和配置
│   │   └── platform.lua     # 平台检测函数（Lua 版）
│   └── plugins/
│       ├── init.lua         # 插件入口：自动发现并返回所有 spec
│       ├── appearance/
│       │   ├── init.lua     # 插件声明（lazy.nvim spec 数组）
│       │   ├── lightline.lua # lightline 配置（可选）
│       │   └── ...
│       ├── general/
│       ├── programming/
│       ├── themes/
│       └── languages/
│           ├── javascript/
│           ├── typescript/
│           └── ...
├── _legacy/                 # 备份的旧配置（可选保留）
├── coc-settings.json        # CoC 配置（保留）
└── after/
    └── ftplugin/            # 文件类型特定设置（可选）
```

#### 关键变更

1. **入口变更**：`init.vim` → `init.lua`
2. **插件管理器**：dein.vim → lazy.nvim
3. **配置语言**：VimScript → Lua
4. **自动加载机制**：保留分类目录结构，改用 Lua 实现

### 9.3 详细设计

#### 9.3.1 模块/组件设计

##### init.lua（入口）

```lua
-- 支持 vim 和 nvim
if vim.fn.has('nvim') == 1 then
  require('config')
else
  -- vim 降级：加载基础 VimScript 配置
  vim.cmd('source ' .. vim.fn.stdpath('config') .. '/_legacy/core/core.vim')
end
```

##### lua/config/init.lua（配置入口）

```lua
-- 按顺序加载配置模块
require('config.options')   -- 选项设置
require('config.lazy')      -- lazy.nvim 引导和插件加载
require('config.keymaps')   -- 快捷键（在插件之后，以便覆盖）
require('config.autocmds')  -- 自动命令
```

##### lua/config/lazy.lua（lazy.nvim 引导）

```lua
-- 自动安装 lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件
require('lazy').setup('plugins', {
  defaults = { lazy = true },
  install = { colorscheme = { 'sonokai', 'habamax' } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
      },
    },
  },
})
```

##### lua/plugins/init.lua（插件自动发现）

```lua
-- 自动发现所有插件类别目录
local plugins = {}
local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'

-- 获取所有子目录
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
  return items
end

-- 加载每个类别的插件
local categories = scan_dir(plugins_dir)
for _, category in ipairs(categories) do
  local category_path = plugins_dir .. '/' .. category
  -- 检查是否有 init.lua
  local init_file = category_path .. '/init.lua'
  if vim.loop.fs_stat(init_file) then
    local ok, category_plugins = pcall(require, 'plugins.' .. category)
    if ok and type(category_plugins) == 'table' then
      for _, plugin in ipairs(category_plugins) do
        table.insert(plugins, plugin)
      end
    end
  end
  -- 递归处理子目录（如 languages/javascript）
  local subcategories = scan_dir(category_path)
  for _, subcategory in ipairs(subcategories) do
    local sub_init = category_path .. '/' .. subcategory .. '/init.lua'
    if vim.loop.fs_stat(sub_init) then
      local ok, sub_plugins = pcall(require, 'plugins.' .. category .. '.' .. subcategory)
      if ok and type(sub_plugins) == 'table' then
        for _, plugin in ipairs(sub_plugins) do
          table.insert(plugins, plugin)
        end
      end
    end
  end
end

return plugins
```

##### lua/plugins/appearance/init.lua（示例：外观类插件）

```lua
return {
  -- 状态栏
  {
    'itchyny/lightline.vim',
    lazy = false,
    config = function()
      -- 尝试加载配置文件（如果存在）
      pcall(require, 'plugins.appearance.lightline')
    end,
  },
  -- 图标
  {
    'ryanoasis/vim-devicons',
    lazy = false,
  },
  -- 启动页
  {
    'mhinz/vim-startify',
    lazy = false,
    config = function()
      pcall(require, 'plugins.appearance.startify')
    end,
  },
  -- Git 状态
  {
    'airblade/vim-gitgutter',
    event = 'BufReadPost',
    config = function()
      pcall(require, 'plugins.appearance.gitgutter')
    end,
  },
  -- ... 其他外观插件
}
```

##### lua/plugins/themes/init.lua（主题插件 - 精简后）

```lua
return {
  -- 主题必须最先加载，不能懒加载
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = 'espresso'
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_disable_italic_comment = 1
      vim.g.sonokai_disable_italic = 1
      vim.cmd.colorscheme('sonokai')
    end,
  },
  -- 备选主题
  { 'morhetz/gruvbox', lazy = true },
  { 'arcticicestudio/nord-vim', lazy = true },
}
```

##### lua/config/options.lua（选项设置 - 统一）

```lua
local opt = vim.opt
local g = vim.g

-- Leader 键（必须在插件加载前设置）
g.mapleader = '-'
g.maplocalleader = '-'

-- 编码
vim.cmd('set langmenu=zh_cn')
opt.encoding = 'utf-8'

-- UI
opt.number = true
opt.wrap = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.colorcolumn = { '80', '120' }
opt.laststatus = 2
opt.showcmd = true
opt.termguicolors = true
opt.background = 'dark'

-- 编辑
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true

-- 搜索
opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true
opt.matchtime = 5

-- 行为
opt.autoread = true
opt.autochdir = true
opt.mouse = 'a'
opt.backspace = { 'indent', 'eol', 'start' }
opt.history = 400

-- 备份（统一设置，消除重复）
opt.backup = false
opt.writebackup = false

-- 更新时间（CoC 推荐）
opt.updatetime = 300

-- 折叠
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevelstart = 99  -- 修复：默认展开所有折叠

-- 铃声
opt.errorbells = false
opt.visualbell = false

-- 兼容性（Neovim 默认已禁用，无需设置）
-- opt.compatible = false  -- 移除重复设置
```

##### lua/config/keymaps.lua（快捷键）

```lua
local map = vim.keymap.set

-- 快速打开/重载配置
map('n', '<leader>ev', ':e $MYVIMRC<CR>', { desc = 'Edit vimrc' })
map('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = 'Source vimrc' })

-- Quickfix
map('n', '<leader>cc', ':cclose<CR>', { desc = 'Close quickfix' })
map('n', '<leader>co', ':copen<CR>', { desc = 'Open quickfix' })

-- 选择当前单词
map('n', '<space>', 'viw', { desc = 'Select word' })

-- 复制/粘贴到系统剪贴板
map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
map('v', '<leader>Y', '"+Y', { desc = 'Copy line to clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
map('n', '<leader>P', '"+P', { desc = 'Paste before from clipboard' })

-- 窗口导航
map('n', '<C-j>', '<C-w>j', { silent = true, desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { silent = true, desc = 'Window up' })
map('n', '<C-h>', '<C-w>h', { silent = true, desc = 'Window left' })
map('n', '<C-l>', '<C-w>l', { silent = true, desc = 'Window right' })

-- 切换搜索高亮
map('n', '<leader>/', ':set hlsearch! hlsearch?<CR>', { desc = 'Toggle search highlight' })

-- Neovim 特定
if vim.fn.has('nvim') == 1 then
  map('n', '<BS>', '<C-w>h', { silent = true })
end
```

##### lua/config/autocmds.lua（自动命令 - 带 augroup）

```lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 文件类型关联
augroup('FileTypeAssociations', { clear = true })
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeAssociations',
  pattern = { '*.jshintrc', '*.eslintrc', '*.changelogrc' },
  callback = function() vim.bo.filetype = 'json' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeAssociations',
  pattern = { 'Podfile', '*.podspec' },
  callback = function() vim.bo.filetype = 'ruby' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeAssociations',
  pattern = { '*.gyp', '*.gypi', 'DEPS' },
  callback = function()
    vim.bo.filetype = 'python'
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeAssociations',
  pattern = '*.supp',
  callback = function() vim.bo.filetype = 'supp' end,
})

-- Startify 禁用折叠
augroup('StartifySettings', { clear = true })
autocmd('FileType', {
  group = 'StartifySettings',
  pattern = 'startify',
  callback = function() vim.wo.foldenable = false end,
})
```

##### lua/config/platform.lua（平台检测）

```lua
local M = {}

function M.is_macos()
  return vim.fn.has('macunix') == 1
end

function M.is_linux()
  return vim.fn.has('unix') == 1 and not M.is_macos() and vim.fn.has('win32unix') == 0
end

function M.is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

function M.is_nvim()
  return vim.fn.has('nvim') == 1
end

function M.is_gui()
  return vim.fn.has('gui_running') == 1 or vim.g.neovide ~= nil
end

return M
```

#### 9.3.2 数据模型

无新增数据模型，配置文件即数据。

#### 9.3.3 主要流程

```
启动流程：
┌─────────────────┐
│    init.lua     │
└────────┬────────┘
         │ require('config')
         ▼
┌─────────────────┐
│ config/init.lua │
└────────┬────────┘
         │
    ┌────┴────┬────────────┬─────────────┐
    ▼         ▼            ▼             ▼
┌────────┐ ┌────────┐ ┌──────────┐ ┌──────────┐
│options │ │  lazy  │ │ keymaps  │ │ autocmds │
└────────┘ └────┬───┘ └──────────┘ └──────────┘
                │
                ▼
         ┌──────────────┐
         │ plugins/init │
         └──────┬───────┘
                │ 自动发现
    ┌───────────┼───────────┬───────────┐
    ▼           ▼           ▼           ▼
┌────────┐ ┌─────────┐ ┌───────────┐ ┌────────┐
│ themes │ │appearance│ │programming│ │ general│
└────────┘ └─────────┘ └───────────┘ └────────┘
```

### 9.4 备选方案

| 方案 | 优点 | 缺点 | 决策 |
|------|------|------|------|
| A. 完全重构 | 最干净 | 工作量大，风险高 | 拒绝 |
| B. 渐进迁移（选中） | 风险可控，保持兼容 | 可能有遗留代码 | **选中** |
| C. 最小修复 | 工作量最小 | 不解决根本问题 | 拒绝 |

| 插件管理器 | 优点 | 缺点 | 决策 |
|------------|------|------|------|
| lazy.nvim（选中） | 现代、懒加载、活跃社区 | 需要迁移 | **选中** |
| packer.nvim | 成熟 | 已停止维护 | 拒绝 |
| 保留 dein.vim | 无需迁移 | 功能有限 | 拒绝 |

### 9.5 实施与迁移计划

#### 实施顺序

1. **创建目录结构**
   - 创建 `lua/config/` 目录
   - 创建 `lua/plugins/` 及子目录
   - 创建 `_legacy/` 备份目录

2. **建立 lazy.nvim 框架**
   - 编写 `init.lua`
   - 编写 `lua/config/init.lua`
   - 编写 `lua/config/lazy.lua`
   - 编写 `lua/plugins/init.lua`（自动发现）

3. **迁移插件声明**
   - 迁移 themes（优先，确保主题可用）
   - 迁移 appearance
   - 迁移 general
   - 迁移 programming
   - 迁移 languages/*

4. **迁移核心配置**
   - 编写 `lua/config/options.lua`
   - 编写 `lua/config/keymaps.lua`
   - 编写 `lua/config/autocmds.lua`
   - 编写 `lua/config/platform.lua`

5. **迁移插件配置**
   - 逐个迁移各插件的配置文件
   - 确保功能等价

6. **清理与优化**
   - 消除重复设置
   - 修复 autocmd（augroup）
   - 精简主题
   - 更新 startify 命令
   - 配置 ALE/CoC 分工

7. **添加 vim 兼容层**
   - 在 `init.lua` 中添加 vim 检测
   - 保留精简的 VimScript 配置供 vim 使用

#### 风险缓解

| 风险 | 缓解策略 |
|------|----------|
| 插件不兼容 | 逐个迁移，每步测试 |
| 快捷键丢失 | 迁移后对比验证 |
| 启动失败 | 保留 `_legacy/` 备份 |
| 功能回归 | 使用 `:checkhealth` 验证 |

#### 测试策略

- **单元测试**：每个配置文件单独加载测试
- **集成测试**：完整启动 Neovim 测试
- **功能测试**：
  - `:Lazy` 命令可用
  - 所有快捷键正常
  - LSP/CoC 功能正常
  - 主题正确加载
  - 启动页正常显示
- **性能测试**：`nvim --startuptime` 对比

#### 回滚方案

1. 将 `_legacy/` 内容恢复到原位置
2. 删除 `lua/` 目录
3. 将 `init.lua` 改回 `init.vim`（或删除 `init.lua`）

## 10. TBD 列表

| ID | 项目 | 缺失信息 | 下一步 |
|----|------|----------|--------|
| TBD-1 | GUI 配置迁移 | gui.vim 中的 VimR/nvim-qt 配置是否需要迁移 | 按需迁移，暂时保留在 _legacy |
| TBD-2 | 箭头键修复 | arrowkey-fix.vim 在现代终端是否仍需要 | 测试后决定是否保留 |
| TBD-3 | Copilot 代理 | copilot_proxy 配置是否需要环境变量化 | 用户决定 |

---

Spec + RFC 包含 10 个章节，最后一个章节是「TBD 列表」，内容完整。
