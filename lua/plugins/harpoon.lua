return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- set keymaps
		local map = vim.keymap.set -- for conciseness
		-- harpoon
		map("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
		map("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
		map("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>")
		map("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>")

		map("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
		map("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
		map("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
		map("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")

		map("n", "<A-u>", ":lua require('harpoon.ui').nav_file(1)<CR>")
		map("n", "<A-i>", ":lua require('harpoon.ui').nav_file(2)<CR>")
		map("n", "<A-o>", ":lua require('harpoon.ui').nav_file(3)<CR>")
		map("n", "<A-h>", ":lua require('harpoon.ui').nav_file(4)<CR>")

		map("n", "<leader>h1", ":lua require('harpoon.term').gotoTerminal(1)<CR>")
		map("n", "<leader>h2", ":lua require('harpoon.term').gotoTerminal(2)<CR>")
		map("n", "<leader>h3", ":lua require('harpoon.term').gotoTerminal(3)<CR>")
		map("n", "<leader>h4", ":lua require('harpoon.term').gotoTerminal(4)<CR>")
		map("n", "<leader>tt", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>")
	end,
}
