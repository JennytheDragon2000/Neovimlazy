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

-- auto-reload files changed outside of neovim
set.autoread = true
local reload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = reload_group,
  callback = function(args)
    local bufnr = args.buf
    local file = vim.api.nvim_buf_get_name(bufnr)
    if file == "" or not vim.uv.fs_stat(file) then return end

    local w = vim.uv.new_fs_event()
    local function watch()
      w:start(file, {}, vim.schedule_wrap(function()
        w:stop()
        if vim.api.nvim_buf_is_valid(bufnr) and vim.uv.fs_stat(file) then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("silent! edit!")
          end)
          watch()
        end
      end))
    end
    watch()

    vim.api.nvim_create_autocmd("BufDelete", {
      buffer = bufnr,
      once = true,
      callback = function() w:stop() end,
    })
  end,
})


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
