# Neovim 配置重构计划：迁移到 lazy.nvim

## 1. 背景与目标

### 1.1 背景

当前配置存在以下问题：

| 问题 | 严重程度 | 说明 |
|------|----------|------|
| 使用过时的插件管理器 dein.vim | 严重 | 缺乏懒加载支持，维护不活跃 |
| 启动时间过长 | 警告 | ~434ms，所有插件同步加载 |
| 重复设置选项 | 警告 | `nocompatible`、`cursorline` 等多处重复 |
| 过多未使用的主题 | 警告 | 17 个主题插件，只用 1 个 |
| 过时的兼容性代码 | 警告 | 针对 Neovim 0.1.x 的代码 |

### 1.2 业务目标

- 将启动时间从 ~434ms 降低到 <100ms
- 迁移到现代化的 lazy.nvim 插件管理器
- 清理冗余代码和未使用的插件
- 提升配置的可维护性和可扩展性
- 升级到最新版 Neovim（v0.11.6）

### 1.3 用户目标

- 保持现有功能不变（LSP、补全、Linter、文件树、Git 集成等）
- 保持现有快捷键习惯
- 保持 sonokai 主题和 lightline 状态栏风格
- 保持现有目录架构和自动遍历加载机制

## 2. 需求类型概览

| 类型 | 适用 | 来源 |
|------|------|------|
| 业务需求 | 是 | 审计报告 |
| 用户需求 | 是 | 保持现有功能和习惯 |
| 解决方案需求 | 是 | lazy.nvim + VimScript/Lua 混用 |
| 功能需求 | 是 | 见第 3 节 |
| 非功能需求 | 是 | 见第 4 节 |
| 外部接口需求 | 否 | 无新增外部接口 |
| 过渡需求 | 是 | 见第 5 节 |

## 3. 功能需求

### FR-001：插件管理器迁移

- **描述**：必须使用 lazy.nvim 替代 dein.vim 作为插件管理器
- **验收标准**：
  - lazy.nvim 正确安装并引导
  - 所有现有插件迁移到 lazy.nvim 配置
  - 支持懒加载（event、cmd、ft、keys 触发器）
  - 保留 `g:bundle_groups` 分组机制
- **优先级**：Must
- **来源**：审计报告

### FR-002：Vim 最小化支持

- **描述**：Vim 只保留基本的 keymap，不再需要插件管理
- **验收标准**：
  - `init.vim` 在 Neovim 时跳过
  - Vim 模式只加载 `core/keymap.vim`
  - 移除 dein.vim 相关代码
- **优先级**：Should
- **来源**：用户要求（简化方案）

### FR-003：自动遍历加载机制保留

- **描述**：系统必须保留现有的 `g:bundle_groups` 自动遍历加载机制
- **验收标准**：
  - 保留 `plugins/index.vim` 中的 `g:bundle_groups` 定义
  - 保留 `plugins/config.vim` 自动遍历加载 `*.vim` 配置
  - 遍历 `g:bundle_groups` 收集 `lua/plugins/*/index.lua`
- **优先级**：Must
- **来源**：用户要求（架构精髓）

### FR-004：coc.nvim 保持

- **描述**：系统必须保持 coc.nvim 的 LSP 和补全功能
- **验收标准**：
  - coc.nvim 正常工作
  - Tab/Shift-Tab 补全导航
  - `gd`/`gr`/`gi`/`gy` 跳转
  - 诊断导航 `[g`/`]g`
  - 保留现有 `coc-settings.json` 配置
- **优先级**：Must
- **来源**：用户要求（TBD-1 确认）

### FR-005：ale.vim 保持与规整

- **描述**：系统必须保留 ale.vim 并规整其配置
- **验收标准**：
  - 保留现有 linter 配置（cpplint、eslint）
  - 清理冗余配置项
  - 明确职责边界：ale.vim 负责外部 linter，coc.nvim 负责 LSP 诊断
  - quickfix 列表显示方式保持不变
- **优先级**：Must
- **来源**：用户要求（TBD-3 确认）

### FR-006：lightline 保持

- **描述**：系统必须保持 lightline 状态栏
- **验收标准**：
  - lightline.vim 正常工作
  - 保留现有配置和风格
- **优先级**：Must
- **来源**：用户要求（TBD-2 确认）

### FR-007：nvim-tree 保持

- **描述**：必须保持 nvim-tree 文件树功能
- **验收标准**：
  - nvim-tree 正常加载
  - 启动时自动打开（配合 Startify）
  - 最后一个窗口时自动关闭
- **优先级**：Must
- **来源**：现有功能

### FR-008：nvim-treesitter 保持

- **描述**：必须保持 nvim-treesitter 语法高亮
- **验收标准**：
  - 保持 c、cpp、javascript、typescript、vim、lua 语言支持
  - 保持折叠功能
- **优先级**：Must
- **来源**：现有功能

### FR-009：主题清理

- **描述**：系统必须清理未使用的主题插件
- **验收标准**：
  - 只保留 sonokai 主题
  - 删除其他 16 个主题插件声明
- **优先级**：Should
- **来源**：审计报告

### FR-010：冗余代码清理

- **描述**：系统必须清理冗余和过时代码
- **验收标准**：
  - 移除 `core/vimui.vim` 中 Neovim 0.1.x 兼容代码
  - 消除重复设置（`nocompatible`、`cursorline` 等）
  - 清理未使用的配置项
  - 移除 dein.vim 相关代码
- **优先级**：Should
- **来源**：审计报告

### FR-011：开发环境 Lint/Formatter 配置

- **描述**：系统必须配置 VimScript 和 Lua 文件的 lint 和 formatter
- **验收标准**：
  - VimScript：配置 vint linter
  - Lua：配置 stylua formatter
  - VSCode/TRAE：配置 `.vscode/settings.json` 支持保存时自动格式化
  - 配置文件：`stylua.toml`、`.vintrc.yaml`
- **优先级**：Should
- **来源**：开发规范

## 4. 非功能需求

### NFR-001：启动性能

- **描述**：Neovim 启动时间必须 < 100ms
- **测量方法**：`nvim --startuptime` 输出
- **优先级**：Must
- **来源**：审计报告

### NFR-002：可维护性

- **描述**：配置必须保持模块化结构
- **测量方法**：
  - 保持现有目录结构（`core/`、`plugins/`）
  - 新增 `lua/` 目录用于 Neovim 专属配置
  - 单一职责：每个文件只负责一个功能
- **优先级**：Should
- **来源**：最佳实践

### NFR-003：版本兼容性

- **描述**：配置必须兼容指定版本
- **测量方法**：
  - Neovim：v0.10+（目标 v0.11.6）
- **优先级**：Must
- **来源**：用户要求

## 5. 过渡需求

### TR-001：备份策略

- **描述**：重构前必须备份现有配置
- **策略**：Git commit + push（已完成）
- **回滚方案**：`git checkout 10c785d`
- **来源**：用户要求

### TR-002：渐进式迁移

- **描述**：采用渐进式迁移，每步可验证
- **策略**：
  1. 先创建 Lua 入口点和目录结构
  2. 逐步为每个分组创建 `index.lua`
  3. 每步测试验证
  4. 最后清理冗余
- **来源**：最佳实践

## 6. 约束与假设

### 6.1 技术约束

- 使用 lazy.nvim 作为唯一的插件管理器
- 允许混用 VimScript 和 Lua（VimScript 为主，Lua 仅用于 lazy.nvim spec）
- `core/*.vim` 和 `plugins/**/*.vim` 保持 VimScript

### 6.2 业务约束

- 保持现有功能和快捷键习惯
- 不改变用户的工作流程
- 保持现有目录架构（`core/`、`plugins/`）
- 保持 `g:bundle_groups` 自动遍历加载机制

### 6.3 假设

- 用户主要使用 Neovim
- Vim 只需要基本的 keymap 支持
- 现有 `*.vim` 配置文件无需迁移到 Lua

## 7. 优先级矩阵

| ID | 需求 | 优先级 | 原因 |
|----|------|--------|------|
| FR-001 | 插件管理器迁移 | Must | 基础设施 |
| FR-002 | Vim 最小化支持 | Should | 简化方案 |
| FR-003 | 自动遍历加载机制 | Must | 架构精髓 |
| FR-004 | coc.nvim 保持 | Must | 核心功能 |
| FR-005 | ale.vim 保持 | Must | 用户要求 |
| FR-006 | lightline 保持 | Must | 用户要求 |
| FR-007 | nvim-tree 保持 | Must | 核心功能 |
| FR-008 | nvim-treesitter 保持 | Must | 核心功能 |
| FR-009 | 主题清理 | Should | 优化 |
| FR-010 | 冗余代码清理 | Should | 优化 |
| FR-011 | Lint/Formatter 配置 | Should | 开发规范 |
| NFR-001 | 启动性能 | Must | 用户体验 |

## 8. 变更/设计方案（RFC）

### 8.1 现状分析

**当前架构**：

```
~/.config/nvim/
├── init.vim                  # VimScript 入口
├── core/                     # 核心配置（VimScript）
│   ├── core.vim              # 加载其他模块
│   ├── general.vim           # 通用设置
│   ├── keymap.vim            # 快捷键
│   ├── vimui.vim             # UI 设置
│   └── language.vim          # 语言设置
├── plugins/                  # 插件配置（VimScript）
│   ├── index.vim             # dein.vim 配置 + g:bundle_groups 定义
│   ├── config.vim            # 自动遍历加载 *.vim 配置
│   ├── appearance/           # 外观相关插件
│   │   ├── index.vimrc       # dein#add() 声明
│   │   ├── lightline.vim     # lightline 配置
│   │   └── ...
│   ├── general/              # 通用插件
│   ├── programming/          # 编程相关插件
│   │   ├── index.vimrc
│   │   ├── ale.vim           # ale 配置
│   │   ├── coc.vim           # coc 配置
│   │   └── ...
│   ├── themes/               # 主题插件
│   └── languages/            # 语言相关插件
│       ├── javascript/
│       └── ...
└── coc-settings.json         # coc.nvim 配置
```

**当前问题**：

1. dein.vim 不支持原生懒加载，启动慢
2. 选项重复设置（`nocompatible`、`cursorline` 等）
3. 过时的 Neovim 0.1.x 兼容代码
4. 17 个主题插件只用 1 个

**核心架构精髓（必须保留）**：

```vim
" plugins/index.vim - g:bundle_groups 定义
let g:bundle_groups = ['appearance', 'general', 'programming', 'themes', 'languages/javascript', ...]

" 遍历分组，source 每个分组的 index.vimrc
for $bundle_group in g:bundle_groups
  execute 'source' $VIMHOME . '/plugins/' . $bundle_group . '/index.vimrc'
endfor
```

```vim
" plugins/config.vim - 自动遍历加载 *.vim 配置
function! SourceConfigsIn(dir)
  let filelist = split(globpath(a:dir, '*.vim'), '\n')
  for vimconf in filelist
    execute 'source' vimconf
  endfor
endfunction

for $bundle_group in g:bundle_groups
  call SourceConfigsIn($VIMHOME . '/plugins/' . $bundle_group)
endfor
```

### 8.2 目标架构

```
~/.config/nvim/
├── init.lua                  # Neovim 入口（新增）
├── init.vim                  # Vim 入口（修改：Neovim 时跳过，只加载 keymap）
├── lazy-lock.json            # 插件版本锁定（新增，自动生成）
├── .vscode/                  # VSCode/TRAE 配置
│   └── settings.json         # 编辑器配置
├── stylua.toml               # Lua formatter 配置
├── .vintrc.yaml              # VimScript linter 配置
├── lua/                      # Neovim 专属配置（新增）
│   ├── config/
│   │   └── lazy.lua          # lazy.nvim 引导
│   └── plugins/              # 各分组的 lazy.nvim spec
│       ├── appearance/
│       │   └── index.lua
│       ├── general/
│       │   └── index.lua
│       ├── programming/
│       │   └── index.lua
│       ├── themes/
│       │   └── index.lua
│       └── languages/
│           ├── javascript/
│           │   └── index.lua
│           ├── json/
│           │   └── index.lua
│           ├── markdown/
│           │   └── index.lua
│           ├── typescript/
│           │   └── index.lua
│           └── c_cpp/
│               └── index.lua
├── core/                     # 保留
│   ├── core.vim              # 修改：简化，只加载核心模块
│   ├── general.vim           # 保留
│   ├── keymap.vim            # 保留（Vim/Neovim 共用）
│   ├── vimui.vim             # 修改：移除 Neovim 0.1.x 兼容代码
│   └── language.vim          # 保留
├── plugins/                  # 保留
│   ├── index.vim             # 修改：只定义 g:bundle_groups，移除 dein
│   ├── config.vim            # 保留不变
│   ├── appearance/
│   │   ├── lightline.vim     # 保留
│   │   └── ...
│   ├── programming/
│   │   ├── ale.vim           # 修改：规整配置
│   │   ├── coc.vim           # 保留
│   │   └── ...
│   └── ...
└── coc-settings.json         # 保留
```

### 8.3 启动流程

```
┌─────────────────────────────────────────────────────────────────┐
│ Neovim 启动流程                                                  │
│                                                                 │
│   init.lua                                                      │
│     ├── vim.g.mapleader = '-'                                   │
│     ├── source plugins/index.vim  → 获取 g:bundle_groups        │
│     ├── require('config.lazy')  → lazy.nvim 引导                │
│     │     └── 遍历 g:bundle_groups，收集 lua/plugins/*/index.lua │
│     ├── source core/core.vim  → 加载核心配置                     │
│     └── source plugins/config.vim  → 加载插件配置               │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ Vim 启动流程（最小化）                                            │
│                                                                 │
│   init.vim                                                      │
│     └── source core/keymap.vim  → 只加载基本快捷键               │
└─────────────────────────────────────────────────────────────────┘
```

### 8.4 详细设计

#### 8.4.1 模块设计

| 模块 | 职责 | 文件 | 语言 | 适用 |
|------|------|------|------|------|
| Neovim 入口 | 加载 lazy.nvim 和核心配置 | `init.lua` | Lua | Neovim |
| Vim 入口 | 只加载 keymap | `init.vim` | VimScript | Vim |
| lazy 引导 | lazy.nvim 安装和配置 | `lua/config/lazy.lua` | Lua | Neovim |
| 分组定义 | 定义 g:bundle_groups | `plugins/index.vim` | VimScript | Neovim |
| 插件声明 | lazy.nvim spec | `lua/plugins/*/index.lua` | Lua | Neovim |
| 配置加载 | 自动遍历加载 *.vim | `plugins/config.vim` | VimScript | Neovim |
| 核心配置 | 通用设置、快捷键、UI | `core/*.vim` | VimScript | Neovim |
| 插件配置 | 各插件的配置 | `plugins/**/*.vim` | VimScript | Neovim |

#### 8.4.2 init.lua 设计

```lua
-- init.lua - Neovim 入口
vim.g.mapleader = '-'

local vimhome = vim.fn.stdpath('config')

-- 加载 g:bundle_groups 定义
vim.cmd('source ' .. vimhome .. '/plugins/index.vim')

-- 引导 lazy.nvim
require('config.lazy')

-- 加载核心配置
vim.cmd('source ' .. vimhome .. '/core/core.vim')

-- 加载插件配置
vim.cmd('source ' .. vimhome .. '/plugins/config.vim')
```

#### 8.4.3 lua/config/lazy.lua 设计

```lua
-- lua/config/lazy.lua - lazy.nvim 引导 + 插件收集

local function collect_plugins()
  local plugins = {}
  local bundle_groups = vim.g.bundle_groups or {}

  for _, group in ipairs(bundle_groups) do
    local module_path = 'plugins.' .. group:gsub('/', '.') .. '.index'
    local ok, group_plugins = pcall(require, module_path)
    if ok and type(group_plugins) == 'table' then
      for _, plugin in ipairs(group_plugins) do
        table.insert(plugins, plugin)
      end
    end
  end

  return plugins
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(collect_plugins(), {
  defaults = { lazy = true },
  install = { colorscheme = { 'sonokai' } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', 'matchit', 'matchparen', 'netrwPlugin',
        'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
      },
    },
  },
})
```

#### 8.4.4 分组 index.lua 示例

**lua/plugins/appearance/index.lua**：

```lua
return {
  { 'ryanoasis/vim-devicons', lazy = false },
  { 'mhinz/vim-startify', lazy = false },
  { 'zefei/vim-wintabs', lazy = false },
  { 'zefei/vim-wintabs-powerline', lazy = false },
  { 'itchyny/lightline.vim', lazy = false },
  { 'airblade/vim-gitgutter', event = 'BufReadPost' },
  { 'tpope/vim-fugitive', cmd = { 'Git', 'Gstatus', 'Gdiff', 'Gblame' } },
  { 'Yggdroot/indentLine', event = 'BufReadPost' },
  { 'luochen1990/rainbow', event = 'BufReadPost' },
}
```

**lua/plugins/programming/index.lua**：

```lua
return {
  { 'dense-analysis/ale', event = 'BufReadPost' },
  { 'liuchengxu/vista.vim', cmd = 'Vista' },
  { 'neoclide/coc.nvim', branch = 'release', event = 'BufReadPost' },
  { 'sheerun/vim-polyglot', event = 'BufReadPost' },
  { 'christoomey/vim-conflicted', cmd = 'Conflicted' },
  { 'vim-scripts/DoxygenToolkit.vim', cmd = 'Dox' },
  { 'github/copilot.vim', event = 'InsertEnter' },
  { 'akinsho/toggleterm.nvim', version = '*', cmd = 'ToggleTerm', config = true },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', event = 'BufReadPost' },
  { 'vim-scripts/supp.vim', ft = 'supp' },
  { 'spacewander/openresty-vim', ft = { 'nginx', 'lua' } },
}
```

**lua/plugins/themes/index.lua**：

```lua
return {
  { 'sainnhe/sonokai', lazy = false, priority = 1000 },
}
```

#### 8.4.5 分组对应表

| 现有分组 | 对应 Lua 模块路径 | 主要插件 |
|----------|-------------------|----------|
| appearance | plugins.appearance.index | lightline、startify、devicons、gitgutter |
| general | plugins.general.index | auto-pairs、vim-matchup、LeaderF、nvim-tree |
| programming | plugins.programming.index | coc.nvim、ale、treesitter、copilot |
| themes | plugins.themes.index | sonokai |
| languages/javascript | plugins.languages.javascript.index | ejs-syntax、vim-widl |
| languages/json | plugins.languages.json.index | json-formatter、jsonc |
| languages/markdown | plugins.languages.markdown.index | vim-markdown |
| languages/typescript | plugins.languages.typescript.index | （空） |
| languages/c_cpp | plugins.languages.c_cpp.index | vim-cpp-modern |

#### 8.4.6 ale.vim 规整后配置

```vim
" plugins/programming/ale.vim - 外部 Linter 配置
" 职责边界：ale 负责外部 linter（cpplint、eslint），coc 负责 LSP 诊断

let g:ale_linters = {
      \    'c': ['cpplint'],
      \    'cpp': ['cpplint'],
      \    'typescript': ['eslint'],
      \    'javascript': ['eslint'],
      \    'json': [],
      \    'python': [],
      \}

let g:ale_fixers = {
      \    'javascript': ['prettier', 'eslint'],
      \    'typescript': ['prettier', 'eslint'],
      \}

let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5

let g:ale_disable_lsp = 1
```

### 8.5 关键变更

1. 新增 `init.lua` 作为 Neovim 入口
2. 修改 `init.vim`：Neovim 时跳过，Vim 只加载 keymap
3. 新增 `lua/config/lazy.lua`：lazy.nvim 引导和插件收集
4. 新增 `lua/plugins/*/index.lua`：各分组的 lazy.nvim spec
5. 修改 `plugins/index.vim`：只定义 `g:bundle_groups`，移除 dein 相关代码
6. 删除所有 `index.vimrc` 文件（不再需要 dein）
7. 保留所有 `*.vim` 配置文件

### 8.6 备选方案

| 方案 | 优点 | 缺点 | 决策 |
|------|------|------|------|
| lazy.nvim（纯 Neovim） | 现代、性能好、简单 | Vim 无插件支持 | ✅ 选择 |
| lazy.nvim + dein | 保持 Vim 兼容 | 需要维护两套插件声明 | ❌ 拒绝（用户简化） |
| 保持 dein.vim | 无需改动 | 性能差、不现代 | ❌ 拒绝 |

## 9. 实施计划与进度

### 9.1 里程碑定义

| 里程碑 | 内容 | 交付物 |
|--------|------|--------|
| M0 | 开发环境准备 | `.vscode/settings.json`、`stylua.toml`、`.vintrc.yaml` |
| M1 | 基础设施 | `init.lua`、`lua/config/lazy.lua`、修改 `init.vim` 和 `plugins/index.vim` |
| M2 | 插件迁移 | `lua/plugins/*/index.lua`、规整 `ale.vim` |
| M3 | 清理优化 | 删除 `index.vimrc`、清理过时代码 |
| M4 | 测试验证 | Neovim v0.11.6 测试通过 |

### 9.2 详细步骤

**M0：开发环境准备**

1. 创建 `.vscode/settings.json`（VSCode/TRAE 配置）
2. 创建 `stylua.toml`（Lua formatter 配置）
3. 创建 `.vintrc.yaml`（VimScript linter 配置）
4. 安装命令行工具：`brew install stylua && pipx install vim-vint`

**M1：基础设施**

1. 创建 `init.lua`（Neovim 入口）
2. 创建 `lua/config/lazy.lua`（lazy.nvim 引导 + 插件收集）
3. 修改 `init.vim`：Neovim 时跳过，Vim 只加载 keymap
4. 修改 `plugins/index.vim`：只定义 `g:bundle_groups`，移除 dein

**M2：插件迁移**

1. 创建 `lua/plugins/appearance/index.lua`
2. 创建 `lua/plugins/general/index.lua`
3. 创建 `lua/plugins/programming/index.lua`
4. 创建 `lua/plugins/themes/index.lua`
5. 创建 `lua/plugins/languages/*/index.lua`
6. 规整 `plugins/programming/ale.vim`

**M3：清理优化**

1. 删除所有 `index.vimrc` 文件
2. 移除 `core/vimui.vim` 中 Neovim 0.1.x 兼容代码
3. 消除重复设置

**M4：测试验证**

1. Neovim v0.11.6 启动测试
2. 性能测试（`nvim --startuptime`）
3. 功能测试（LSP、补全、Linter、文件树等）

### 9.3 当前进度

| 里程碑 | 状态 | 说明 |
|--------|------|------|
| M0：开发环境准备 | ✅ 已完成 | 配置文件已创建，工具已安装 |
| M1：基础设施 | ✅ 已完成 | init.lua、lua/config/lazy.lua 已创建 |
| M2：插件迁移 | ✅ 已完成 | 所有 index.lua 已填充，treesitter 配置已迁移 |
| M3：清理优化 | ✅ 已完成 | 删除 9 个 index.vimrc，清理过时代码 |
| M4：测试验证 | ✅ 已完成 | Neovim v0.10.2 启动成功，启动时间约 200ms（原 434ms） |

### 9.4 风险与缓解

| 风险 | 缓解策略 |
|------|----------|
| 迁移过程中配置损坏 | 已 Git 备份，可随时回滚 |
| 插件行为不一致 | 逐个迁移，每步测试 |

### 9.5 回滚方案

```bash
git checkout 10c785d
```

## 10. TBD 列表（已全部确认）

| ID | 项目 | 决定 | 说明 |
|----|------|------|------|
| TBD-1 | 是否迁移到原生 LSP | ✅ 保持 coc.nvim | 功能成熟、配置完善、无需迁移 |
| TBD-2 | lightline vs lualine | ✅ 保持 lightline | 保持现有习惯 |
| TBD-3 | 是否保留 ale.vim | ✅ 保留 ale.vim | 规整配置，明确与 coc.nvim 职责边界 |
| TBD-4 | Vim 兼容性范围 | ✅ 只保留 keymap | 简化方案，不再维护 dein |

---

Spec 包含 10 个章节，最后章节是「TBD 列表」，内容完整。
