return {
'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                              , branch = '0.1.x',
dependencies = { 'nvim-lua/plenary.nvim' },
config = function()
local map = vim.keymap.set -- for conciseness
map("n", "<A-f>", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>") -- list available keymaps
map("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>") -- list available colorschemes
map("n", "<space>fb", ":Telescope file_browser<CR>", { noremap = true })
map("n", "<space>fm", ":Telescope marks<CR>", { noremap = true })
end


    }
