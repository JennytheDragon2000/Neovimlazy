return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		-- configurations go here
		bg_x_padding = 122,
		bg_y_padding = 82,
		-- bg_padding = nil,
	},
}
--
-- return {
-- 	"Bekaboo/dropbar.nvim",
-- 	name = "dropbar",
-- 	dependencies = {
-- 		"nvim-telescope/telescope-fzf-native.nvim", -- optional dependency
-- 	},
-- 	opts = {
-- 		config = function()
-- 			local dropbar_api = require("dropbar.api")
--
-- 			-- Keymaps for dropbar functionality
-- 			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
-- 			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
-- 			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
-- 		end,
-- 	},
-- }
