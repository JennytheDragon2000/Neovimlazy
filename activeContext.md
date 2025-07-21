# Active Context

## Auto-suggestion Fix (2025-07-15)

### Problem
User couldn't accept auto-suggestions in Neovim configuration.

### Analysis
- Found nvim-cmp configuration only had `<Right>` mapped for accepting suggestions
- Supermaven AI completion plugin had no explicit keybindings configured
- No clear, intuitive keybindings for accepting different types of suggestions

### Changes Made

#### nvim-cmp.lua
- Added `<CR>` (Enter) to accept LSP suggestions
- Added `<C-y>` (Ctrl+y) to accept LSP suggestions  
- Kept `<Right>` for backward compatibility
- Removed Tab mapping to avoid conflict with Supermaven

#### supermaven.lua
- Configured explicit keybindings:
  - `<Tab>` - Accept AI suggestion
  - `<C-l>` - Accept one word of AI suggestion
  - `<C-]>` - Clear AI suggestion

### Result
Clear separation between LSP completions and AI completions with intuitive keybindings for both.

## Second Fix Attempt (2025-07-15)

### Real Problem Found
Multiple Tab key conflicts:
1. **LuaSnip** was using `<Tab>` for snippet expansion
2. **Supermaven** was using `<Tab>` for AI suggestions  
3. **nvim-cmp** needed Tab for completion menu navigation

### Final Solution

#### nvim-cmp.lua
- Implemented smart Tab handling with fallback hierarchy:
  - If completion menu visible: navigate completions
  - If snippet expandable: expand/jump snippet
  - Otherwise: fallback to default behavior
- Added Shift-Tab for reverse navigation
- Kept Enter and Ctrl+y for accepting completions

#### luasnip.lua
- Removed conflicting Tab mapping
- Now handled entirely through nvim-cmp integration

#### supermaven.lua
- Changed to `<C-a>` for accepting AI suggestions
- Changed to `<A-w>` for accepting one word
- Kept `<C-]>` for clearing suggestions

### Final Keybindings
- **Tab/Shift-Tab**: Navigate and accept completions/snippets
- **Enter**: Accept completion
- **Ctrl+y**: Accept completion
- **Ctrl+a**: Accept AI suggestion (Supermaven)
- **Alt+w**: Accept one word of AI suggestion

## User Preference Update (2025-07-15)

### Change Request
User wanted Tab for AI suggestions only, not for completion menu navigation since Ctrl+j/k already handles that.

### Updated Configuration
- **Supermaven**: Changed back to `<Tab>` for AI suggestions
- **nvim-cmp**: Removed Tab navigation, kept only Shift-Tab for snippet jumping
- **Final keybindings**:
  - **Tab**: Accept AI suggestion (Supermaven)
  - **Ctrl+j/k**: Navigate completion menu
  - **Enter/Ctrl+y**: Accept completion
  - **Shift-Tab**: Jump backwards in snippets
  - **Alt+w**: Accept one word of AI suggestion
  - **Ctrl+]**: Clear AI suggestion

## Plugin Cleanup (2025-07-15)

### Removed Plugins
- **export-colorscheme.nvim** - Niche use case
- **vim-be-good** - Game plugin, not essential
- **webapi-vim** - Unnecessary dependency
- **browser-bookmarks.lua** - Niche feature
- **obsidian.lua** - Not using Obsidian notes

### Also Removed
- Duplicate `vim-tmux-navigator` entry from init.lua

### Additional Cleanup Completed
- **nvim-tree.lua** - Removed (keeping oil as default file manager)
- **neo-tree.lua** - Removed (keeping oil as default file manager)
- **ultisnips.lua** - Removed (keeping LuaSnip)
- **mattn/emmet-vim** - Removed (keeping nvim-emmet)
- **treesitterPlayground.lua** - Removed (deprecated, use :InspectTree instead)

### Keymaps Updated
- Removed `<leader>ee` mapping for NvimTreeToggle
- File exploration now handled by:
  - `-` for oil (default file manager)
  - `<leader>gy` for yazi

### Current File Managers
- **oil** - Primary file manager (mapped to `-`)
- **yazi** - External file manager (mapped to `<leader>gy`)

## Performance Optimizations (2025-07-15)

### Lazy Loading Improvements
- **Telescope**: Added lazy loading with `keys` trigger, moved keymaps to lazy spec
- **Treesitter**: Added `BufReadPre/BufNewFile` events, added build command
- **Supermaven**: Changed from `priority=1000` to `InsertEnter` event
- **Harpoon**: Added lazy loading with `keys` trigger, moved keymaps to lazy spec
- **Comment**: Added `BufReadPre/BufNewFile` events
- **Marks**: Added `BufReadPre/BufNewFile` events

### Performance Benefits
- **Faster startup**: Plugins only load when needed
- **Better memory usage**: Reduced initial plugin loading
- **Improved responsiveness**: Event-driven loading reduces blocking
- **Which-key integration**: Added descriptions for all key mappings

### Key Changes Made
1. **Event-driven loading**: Most plugins now load on specific events
2. **Key-based loading**: Interactive plugins load only when keys are pressed
3. **Removed duplicate keymaps**: Consolidated keymaps into lazy spec
4. **Added descriptions**: All keymaps now have which-key descriptions