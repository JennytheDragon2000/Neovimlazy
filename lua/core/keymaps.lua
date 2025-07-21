vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

local map = vim.keymap.set -- for conciseness
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- basic file edit
map("i", "jj", "<ESC>l")
map("i", "kk", "<ESC>l")
map("i", "jk", "<ESC>l")
map("n", "H", "0")
map("n", "L", "$")
-- map("n", "K", "^") -- Commented out to avoid conflict with LSP hover
map("n", "^", "^") -- Use ^ directly for line start
-- map("n", "<leader>bl", ":luafile %<CR>")
map("n", "<leader>bl", ":so")
map("n", "<leader>nh", ":nohl<CR>")
map("n", "<leader>w", ":w<CR>")
map("n", "<A-w>", ":w<CR>")
map("n", "x", '"_x')
map("n", "<leader>l", ":Lazy<CR>")

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cmd>cprev<CR>")

-- splits
map("n", "<leader>sv", "<C-w>v") -- split vertically
map("n", "<leader>sh", "<C-w>s") -- split horizontally
map("n", "<leader>se", "<C-w>=") -- make split windows equal width
map("n", "<leader>sc", ":close<CR>") -- close current split window

-- -- tabs
-- map("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- map("n", "<leader>tc", ":tabclose<CR>") -- close current tab
-- map("n", "<leader>tn", ":tabn<CR>") -- go to next tab
-- map("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- vim-maximizer
map("n", "<leader>sm", ":MaximizerToggle<CR>")
-- File explorer handled by oil (-) and yazi (<leader>gy)

-- vim-surround
-- ys[motion][character] ex:- ysw" --add
-- ds[character] ex:- ds" --delete
-- cs[character][character] ex:- cs"' --repace

-- replace
-- y[movement] ---> gr[movement]

map("n", "<leader>cx", ":vsplit | :term python3 %<cr>")
-- map("n", "<leader>mm", "o<ESC>j")
-- map("n", "d", '"_d')

-- yank to to system clipboard and paste from it
-- map("n", "p", '"+p')
-- map("v", "p", '"+p')
-- map("n", "y", '"+y')
-- map("v", "y", '"+y')

-- buffer movements
map("n", "<leader>bp", ":bprevious<CR>")
map("n", "<leader>bn", ":bnext<CR>")
map("n", "<C-p>", ":bprevious<CR>")
map("n", "<C-n>", ":bnext<CR>")
map("n", "<leader>bt", ":enew<CR>")
map("n", "<leader>bc", ":bd!<CR>")

-- use vim keys in command mode
-- map("n", ":", "q:i")

-- quit neovim
map("n", "<leader>qq", ":q!<CR>")

-- Move selected line / block of text up and down in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_opts)
map("x", "J", ":move '>+1<CR>gv-gv", default_opts)
-- Move selected line / block of right and left in visual mode
map("v", "H", "<gv")
map("v", "L", ">gv")

map("n", "J", "mzJ`z")

-- replace the word that I'm currently on
map("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>rq", [[:s/(\zs.*\ze)/\=substitute(submatch(0), '\S\+', "'&',", 'g')/<Left><Left><Left>]])

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', default_opts)

map("n", "vv", "V", default_opts)

-- R
map("n", "<Leader>rsr", "<Plug>RStart")
map("n", "<Leader>rsc", "<Plug>RClose")
map("n", "<Leader>rssc", "<Plug>RSaveClose")
map("n", "<Leader>rsl", "<Plug>RSendLine")
map("x", "<Leader>rssl", "<Plug>RSendSelection")

-- pounce
-- map("n", "t", function()
-- 	require("pounce").pounce({ do_repeat = false })
-- end)
-- map("x", "t", function()
-- 	require("pounce").pounce({})
-- end)

-- map("n", "<Leader>m", " <Plug>Lightspeed_omni_s")
-- telescope file browser
-- map("n", "<Leader>m", " <Plug>Lightspeed_omni_s")
-- telescope file browser
-- exit the terminal mode
-- map("t", "<Leader>jj", "<C-\\><C-n>")
map("t", "qq", "<C-\\><C-n>")

-- hatgpt

map("n", "<Leader>cc", ":ChatGPTCompleteCode<CR>")
map("n", "<Leader>ca", ":ChatGPTRun explain_code<CR>")
map("x", "<Leader>a", ":ChatGPTRun explain_code<CR>")
-- map("x", "<C-a>", ":ChatGPTRun explain_code<CR>")

-- backspace erase whole word
map("i", "<C-H>", "<C-W>")

-- next greatest remap ever : asbjornHaland
vim.keymap.set("x", "<leader>p", [["+dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("n", "<leader>p", [["+p]])
map({ "n", "v" }, "<leader>d", [["_d]])

-- Delete operations that shouldn't pollute clipboard
map("n", "c", '"_c')
map("n", "C", '"_C')
map("n", "s", '"_s')
map("n", "S", '"_S')
map("v", "c", '"_c')
map("v", "s", '"_s')

-- Define key mapping
map("n", "<leader>nm", "/((<>))<CR>cgn")
map("n", "<leader>nn", "/><<CR>a")
map("n", "dl", "^v$d")

-- map("i", "<leader>nn", "<ESC>/><<CR>a")
-- helllo thre can you make things((<>))which is related
-- helllo thre can you make things((<>))which is related
-- helllo thre can you make things((<>))which is related
-- helllo thre can you make things((<>))which is related
-- vim.g.UltiSnipsExpandTrigger = "<tab>"

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- map("n", "<leader>e", ":Neotree toggle<CR>") -- split vertically
-- Shortcut to go to the next position
vim.g.UltiSnipsJumpForwardTrigger = "<C-A-j>"

-- Shortcut to go to the previous position
vim.g.UltiSnipsJumpBackwardTrigger = "<C-A-k>"

vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "my_snippets" }

-- Set g:user_emmet_leader_key to ','
vim.g.user_emmet_leader_key = ","
vim.g.user_emmet_next_key = ",."
-- vim.g.user_emmet_mode = "a"

-- http://www.google.com/
map(
	"n",
	"<leader>tj",
	":!kitty @ --to=unix:/tmp/mykitty launch --cwd=current /home/srinath/scripts/tmux-sessionizer<CR>"
)
-- map("n", "<Leader><leader>", ":HopChar2<CR>")
map("n", "<Leader>rp", ":w !python<CR>")
map("i", "<Leader>ww", "<ESC>:w<CR>")

-- Java-specific keymaps (defined globally, will be overridden by jdtls buffer-specific ones)
map("n", "<leader>jc", ":!javac %<CR>", { desc = "Compile Java file" })
map("n", "<leader>jr", ":!java %:r<CR>", { desc = "Run Java file" })
map("n", "<leader>jj", ":!javac % && java %:r<CR>", { desc = "Compile and run Java file" })
