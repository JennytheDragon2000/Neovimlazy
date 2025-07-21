# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Repository

This is a personal Neovim configuration directory (`~/.config/nvim`) using Lua for configuration. The setup uses the `lazy.nvim` plugin manager and follows a modular architecture.

## Architecture Overview

The configuration is organized into several key modules:

- **`init.lua`** - Main entry point that loads core settings and lazy plugin manager
- **`lua/core/`** - Core Neovim configuration
  - `basic-settings.lua` - Fundamental Neovim options (line numbers, tabs, search, etc.)
  - `keymaps.lua` - Custom key mappings and leader key configuration
- **`lua/lazy/`** - Plugin manager setup
  - `lazy.lua` - Lazy.nvim configuration and plugin loading
- **`lua/plugins/`** - Plugin configurations (each plugin has its own file)
  - `init.lua` - Basic plugins without complex configuration
  - Individual plugin files for complex setups (LSP, telescope, etc.)
- **`lua/user/`** - User-specific customizations
  - `snips.lua` - Custom snippets
- **`my_snippets/`** - Custom snippet files for different languages

## Key Configuration Details

### Leader Key
- Leader key is set to `<Space>` (space bar)
- Most custom mappings use the leader key prefix

### Plugin Management
- Uses `lazy.nvim` for plugin management
- Plugins are automatically imported from `plugins/` and `plugins/lsp/` directories
- Change detection notifications are disabled for a cleaner experience

### Essential Settings
- Relative line numbers enabled
- Tab width set to 4 spaces with expandtab
- Clipboard integration with system clipboard
- Smart case-insensitive search
- Cursor line and column highlighting
- No swap files or backup files

### Custom Snippets
- UltiSnips is configured with custom snippet directories
- Snippets are stored in `my_snippets/` directory
- Jump forward: `<C-A-j>`, Jump backward: `<C-A-k>`

## Working with This Configuration

### Testing Changes
- Use `:so` (source) to reload the current file
- Use `<leader>bl` to source the current buffer
- Use `<leader>l` to open Lazy plugin manager

### File Navigation
- Oil.nvim is mapped to `-` for directory browsing
- NvimTree toggle is mapped to `<leader>ee`
- Buffer navigation: `<C-p>` (previous), `<C-n>` (next)

### Common Workflows
1. **Adding a new plugin**: Create a new file in `lua/plugins/` or add to `lua/plugins/init.lua`
2. **Modifying keymaps**: Edit `lua/core/keymaps.lua`
3. **Changing basic settings**: Edit `lua/core/basic-settings.lua`
4. **Adding snippets**: Create files in `my_snippets/` directory

### Important Notes
- Configuration uses Lua, not Vimscript
- Leader key mappings are extensive and well-documented in keymaps.lua
- The setup includes LSP configuration in `plugins/lsp/` directory
- Custom terminal integration and tmux navigation is configured