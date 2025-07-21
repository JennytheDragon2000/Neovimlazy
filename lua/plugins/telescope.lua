return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	lazy = true,
	cmd = "Telescope",
	keys = {
		{ "<A-f>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
		{ "<space>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
		{ "<leader>fd", function() require("telescope").extensions.zoxide.list() end, desc = "Zoxide" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"jvgrootveld/telescope-zoxide",
	},
	config = function()
		require("telescope").load_extension("zoxide")
	end,
}
