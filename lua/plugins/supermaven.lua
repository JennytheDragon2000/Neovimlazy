return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>", -- Accept AI suggestion with Tab
				clear_suggestion = "<C-]>", -- Clear AI suggestion
				accept_word = "<A-w>", -- Accept one word of AI suggestion
			},
		})
	end,
}
