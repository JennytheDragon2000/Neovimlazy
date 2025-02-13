return {
	"romgrk/barbar.nvim",

	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		require("barbar").setup({
			animation = false,
			-- auto_hide = true,
			clickable = false,
			focus_on_close = "left",
			highlight_alternate = false,
			highlight_visible = false,
			icons = {
				button = "",
				separator = { left = "", right = "" },
				inactive = { separator = { left = "", right = "" } },
				pinned = { button = "" },
			},
		})

		-- Move to previous/next
		-- map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
		-- map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
		map("n", "<leader>th", "<Cmd>BufferPrevious<CR>", opts)
		map("n", "<leader>tl", "<Cmd>BufferPrevious<CR>", opts)
		-- Re-order to previous/next
		map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
		map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
		-- Goto buffer in position...
		map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
		map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
		map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
		map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
		map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
		map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
		map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
		map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
		map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
		map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
		-- Pin/unpin buffer
		map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
		-- Close buffer
		map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
		map("n", "<C-t>", "<Cmd>BufferPick<CR>", opts)
		-- Sort automatically by...
		map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
		map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
		-- map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
		map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

		map("n", "<C-t>", "<Cmd>BufferPick<CR>", opts)
		map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
		map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
		map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

		-- vim.cmd("highlight BufferCurrentSign guibg=NONE guifg=#254157 ctermfg=NONE ctermbg=NONE")
		vim.cmd([[highlight BufferCurrent NONE]])
		vim.cmd([[highlight BufferCurrentMod NONE]])
		vim.cmd([[highlight BufferVisible NONE]])
		vim.cmd("highlight BufferCurrentSign guibg=NONE guifg=#254157 ctermfg=NONE ctermbg=NONE")
	end,
}
