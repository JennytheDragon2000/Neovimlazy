return {
	"ThePrimeagen/harpoon",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>ha", function() require('harpoon.mark').add_file() end, desc = "Harpoon add file" },
		{ "<leader>ht", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Harpoon menu" },
		{ "<leader>hn", function() require('harpoon.ui').nav_next() end, desc = "Harpoon next" },
		{ "<leader>hp", function() require('harpoon.ui').nav_prev() end, desc = "Harpoon prev" },
		{ "<leader>1", function() require('harpoon.ui').nav_file(1) end, desc = "Harpoon file 1" },
		{ "<leader>2", function() require('harpoon.ui').nav_file(2) end, desc = "Harpoon file 2" },
		{ "<leader>3", function() require('harpoon.ui').nav_file(3) end, desc = "Harpoon file 3" },
		{ "<leader>4", function() require('harpoon.ui').nav_file(4) end, desc = "Harpoon file 4" },
		{ "<A-u>", function() require('harpoon.ui').nav_file(1) end, desc = "Harpoon file 1" },
		{ "<A-i>", function() require('harpoon.ui').nav_file(2) end, desc = "Harpoon file 2" },
		{ "<A-o>", function() require('harpoon.ui').nav_file(3) end, desc = "Harpoon file 3" },
		{ "<A-h>", function() require('harpoon.ui').nav_file(4) end, desc = "Harpoon file 4" },
		{ "<leader>h1", function() require('harpoon.term').gotoTerminal(1) end, desc = "Harpoon term 1" },
		{ "<leader>h2", function() require('harpoon.term').gotoTerminal(2) end, desc = "Harpoon term 2" },
		{ "<leader>h3", function() require('harpoon.term').gotoTerminal(3) end, desc = "Harpoon term 3" },
		{ "<leader>h4", function() require('harpoon.term').gotoTerminal(4) end, desc = "Harpoon term 4" },
		{ "<leader>tt", function() require('harpoon.cmd-ui').toggle_quick_menu() end, desc = "Harpoon cmd menu" },
	},
	config = function()
		-- Harpoon setup if needed
	end,
}
