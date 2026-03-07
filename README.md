# Neovim Configuration

A modern Neovim configuration using Lua and lazy.nvim.

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- Node.js (for coc.nvim)

## Installation

```sh
git clone https://github.com/XadillaX/_vimrc.git ~/.config/nvim
```

Open Neovim and plugins will be installed automatically via lazy.nvim.

## Plugin Management

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

### Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open lazy.nvim UI |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Sync plugins |
| `:Lazy check` | Check for updates |

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/              # Core configuration
│   │   ├── init.lua         # Config loader
│   │   ├── options.lua      # Vim options
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── autocmds.lua     # Auto commands
│   │   └── lazy.lua         # Plugin manager setup
│   └── plugins/             # Plugin configurations
│       ├── appearance/      # UI plugins (lightline, startify, etc.)
│       ├── general/         # General plugins (nvim-tree, git-blame, etc.)
│       ├── programming/     # Dev plugins (coc, treesitter, copilot, etc.)
│       ├── themes/          # Color schemes (sonokai)
│       └── languages/       # Language-specific plugins
├── autoload/                # Vim autoload functions
└── coc-settings.json        # coc.nvim configuration
```

## Key Mappings

| Key | Description |
|-----|-------------|
| `<leader>fl` | Toggle file tree |
| `<C-h/j/k/l>` | Window navigation |
| `<leader>y` | Copy to clipboard |
| `<leader>p` | Paste from clipboard |
| `<F8>` | Toggle Vista (tagbar) |

## Main Plugins

- **Plugin Manager**: lazy.nvim
- **File Explorer**: nvim-tree
- **Status Line**: lightline
- **Completion**: coc.nvim
- **Syntax**: nvim-treesitter
- **AI**: GitHub Copilot
- **Theme**: Sonokai
