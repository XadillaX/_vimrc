# Neovim 配置审计报告

> 生成时间：2026-01-31
> 审计工具：config-auditing skill

## 概要信息

| 指标            | 值                     |
| ------------- | --------------------- |
| **评级**        | **C**                 |
| **Neovim 版本** | v0.10.2               |
| **配置位置**      | `~/.config/nvim`      |
| **插件数量**      | 64 个（通过 dein.vim 管理）  |
| **配置类型**      | VimScript 为主，混合少量 Lua |
| **插件管理器**     | dein.vim              |

### 评级标准

| 等级    | 标准                                  | 描述           |
| ----- | ----------------------------------- | ------------ |
| **A** | 0 Critical，0-2 Warnings             | 优秀 - 生产就绪    |
| **B** | 0 Critical，3-5 Warnings             | 良好 - 有小改进空间  |
| **C** | 0 Critical，6+ Warnings 或 1 Critical | 可接受 - 需要关注   |
| **D** | 2-3 Critical                        | 较差 - 存在重大问题  |
| **F** | 4+ Critical                         | 不及格 - 需要立即修复 |

***

## 🔴 严重问题（Critical）

### 1. 功能冗余：ALE + CoC 同时使用

**文件**：`plugins/programming/index.vimrc:1-3`

```vim
call dein#add('dense-analysis/ale')
call dein#add('neoclide/coc.nvim', ...)
```

**问题**：ALE 和 CoC 都提供 linting/diagnostics 功能，同时使用会导致：

* 重复的诊断信息

* 性能开销

* 潜在的冲突

**建议**：选择其一。推荐保留 CoC（功能更全面），移除 ALE，或者配置 ALE 只用于 CoC 不支持的语言。

***

### 2. 过时的插件管理器

**问题**：dein.vim 虽然仍在维护，但已不是主流选择。现代 Neovim 配置推荐使用 [lazy.nvim](https://github.com/folke/lazy.nvim)。

**影响**：

* 缺乏懒加载的细粒度控制

* 插件启动时间优化有限

* 社区支持和文档相对较少

***

## 🟡 警告（Warnings）

### 1. 重复的选项设置

**发现位置**：

| 选项                 | 重复位置                                                  |
| ------------------ | ----------------------------------------------------- |
| `set nocompatible` | `core/core.vim:5`、`plugins/index.vim:30`              |
| `set nobackup`     | `core/general.vim:17`、`plugins/programming/coc.vim:2` |
| `set cursorline`   | `core/general.vim:19`、`core/vimui.vim:38`             |

**建议**：统一在一个地方设置，避免混淆和维护困难。

***

### 2. Autocmd 未使用 augroup

**文件**：

* `plugins/general/nvim-tree.vim:22-24`

* `plugins/programming/coc.vim:60`

* `plugins/appearance/startify.vim:123`

```vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 ...
autocmd CursorHold * silent call CocActionAsync('highlight')
```

**问题**：不使用 `augroup` 包裹的 autocmd 在重新加载配置时会重复注册。

**修复示例**：

```vim
augroup NvimTreeAutoOpen
  autocmd!
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Startify | execute 'NvimTreeOpen' | wincmd w | endif
augroup END
```

***

### 3. 过多的主题插件

**文件**：`plugins/themes/index.vimrc`

你安装了 **17 个主题插件**，但只使用了 `sonokai`。这会：

* 增加插件管理开销

* 占用磁盘空间

* 延长 `:DeinUpdate` 时间

**建议**：只保留常用的 2-3 个主题。

***

### 4. Leader 键选择不常见

**文件**：`core/keymap.vim:2`

```vim
let mapleader = '-'
```

**问题**：`-` 作为 leader 键不太符合人体工学，且与 Vim 原生的「向上移动一行」功能冲突。

**建议**：考虑使用 `<Space>` 作为 leader（目前 `<space>` 被映射为 `viw`）。

***

### 5. Space 键被占用

**文件**：`core/keymap.vim:10`

```vim
map <space> viw
```

**问题**：这个映射与 CoC 的 `<space>` 前缀映射冲突（`plugins/programming/coc.vim:84-97`）。

***

### 6. 过时的 Neovim 版本检查

**文件**：`core/vimui.vim:6-8`

```vim
elseif has('neovim')
  " for neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
```

**问题**：`has('neovim')` 应该是 `has('nvim')`，且 Neovim 0.1.x 的兼容代码已无意义。

***

## 💡 建议（Suggestions）

### 1. 迁移到 Lua 配置

你的配置主要使用 VimScript，但已经有部分 Lua 代码（nvim-treesitter、nvim-tree、toggleterm）。建议逐步迁移到纯 Lua 配置：

**优势**：

* 更好的性能

* 更强的类型检查（配合 lua-language-server）

* 更现代的 API（`vim.keymap.set`、`vim.api.nvim_create_autocmd`）

* 更好的插件生态支持

***

### 2. 使用 lazy.nvim 替代 dein.vim

**迁移示例**：

```lua
-- lua/plugins/programming.lua
return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "yarn install --frozen-lockfile",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
  },
}
```

***

### 3. 清理未使用的插件配置

**发现**：

* `plugins/general/nerdtree.vim` 中的代码被注释掉了，但文件仍存在

* `plugins/appearance/alpha-nvim.vim` 存在但 `nvim-web-devicons` 依赖被注释

***

### 4. 优化 Treesitter 配置

**当前配置**：`plugins/programming/nvim-treesitter.vim`

```lua
ensure_installed = { 'c', 'cpp', 'javascript', 'typescript', 'vim' },
```

**建议添加**：

```lua
ensure_installed = {
  'c', 'cpp', 'javascript', 'typescript', 'vim',
  'lua', 'vimdoc', 'query', 'json', 'markdown'
},
incremental_selection = { enable = true },
indent = { enable = true },
```

***

### 5. 折叠配置可能导致问题

**文件**：`core/general.vim:44-48`

```vim
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=0
```

**问题**：`foldlevelstart=0` 会导致打开文件时所有内容都被折叠，体验不佳。

**建议**：改为 `set foldlevelstart=99` 或移除此行。

***

### 6. Startify 配置中的过时命令

**文件**：`plugins/appearance/startify.vim:115`

```vim
{ 'f': [ 'File List Tree', 'NERDTreeToggle' ] },
```

**问题**：你已经迁移到 nvim-tree，但 Startify 仍引用 NERDTree 命令。

***

## 📊 统计信息

| 指标           | 数量   |
| ------------ | ---- |
| 严重问题         | 2    |
| 警告           | 6    |
| 建议           | 6    |
| 总插件数         | 64   |
| VimScript 文件 | \~30 |
| Lua 代码块      | 3    |

***

## 🎯 优先修复建议

| 优先级  | 任务                       |
| ---- | ------------------------ |
| 🔴 高 | 解决 ALE + CoC 冲突          |
| 🔴 高 | 将 autocmd 包裹在 augroup 中  |
| 🟡 中 | 清理重复的选项设置                |
| 🟡 中 | 移除未使用的主题插件               |
| 🟢 低 | 考虑迁移到 lazy.nvim + Lua 配置 |

***

## 附录：检测命令

以下命令可用于后续自查：

```bash
# 检查重复设置
grep -rn "set nobackup\|set cursorline\|set nocompatible" ~/.config/nvim --include="*.vim"

# 检查未使用 augroup 的 autocmd
grep -rn "autocmd " ~/.config/nvim --include="*.vim" | grep -v "augroup"

# 统计插件数量
grep -rh "call dein#add" ~/.config/nvim --include="*.vimrc" | wc -l

# 检查废弃 API（针对 Lua 代码）
grep -rn "nvim_buf_set_option\|nvim_win_set_option\|get_active_clients" ~/.config/nvim --include="*.lua"
```

