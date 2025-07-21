local set = vim.opt

-- line numbers
set.relativenumber = true
set.number = true
set.scrolloff = 10 -- cursor won't go to top or end of the file

set.guicursor = "n-v-c:block"
-- backup files
set.swapfile = false
set.backup = false
-- allow to have bufferes in the background without saving it
set.hidden = true


-- copy to clipboard
vim.opt.clipboard:append("unnamedplus")

-- tabs & indentation
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true

-- search settings
set.ignorecase = true
set.smartcase = true

-- cursor line
set.cursorline = true
set.cursorcolumn = true

-- appearance
set.termguicolors = true
set.background = "dark"
set.signcolumn = "yes"

-- backspace
set.backspace = "indent,eol,start"

-- splitwindows
set.splitright = true
set.splitbelow = true

-- set.list = true
-- vim.api.nvim_command("set listchars=eol:⏎ ")

set.hlsearch = false
set.incsearch = true
-- set.mouse = "a" --Enable mouse mode
-- set.mouse = ""
-- set.laststatus = 0 --Always hide the statusline

-- set.showtabline = 2
-- vim.o.shell = "/usr/bin/zsh"

-- set visual selection color to brown
vim.cmd("hi Visual ctermfg=NONE ctermbg=Brown cterm=NONE")
vim.cmd("hi Visual guifg=NONE guibg=Brown gui=NONE")
vim.cmd("set nrformats+=alpha")

-- folding
vim.opt.foldmethod = "manual" -- Set fold method to manual or whichever method you prefer
vim.opt.foldlevelstart = 99 -- Keep all folds closed when opening a file
vim.opt.foldenable = false -- Disable folding by default
-- vim.cmd([[autocmd BufWinLeave * mkview]]) -- Save view (folds, cursor position, etc.) when leaving buffer/window
-- vim.cmd([[autocmd BufWinEnter * silent loadview]]) -- Restore view when entering buffer/window

vim.opt.conceallevel = 2
