return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	dependencies = {
		"nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- configuration goes here
		---@type lc.lang
		lang = "python",
		---@type lc.highlights
		theme = {
			["alt"] = {
				bg = "#152528",
			},
			["normal"] = {
				fg = "#EA4AAA",
			},
		},
	},
}
