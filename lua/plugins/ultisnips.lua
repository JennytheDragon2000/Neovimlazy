return {
	"SirVer/ultisnips",
	lazy = false,
	config = function()
		-- vim.g.UltiSnipsJumpForwardTrigger = "<C-A-j>"
		vim.g.UltiSnipsJumpForwardTrigger = "<C-l>"

		-- Shortcut to go to the previous position
		vim.g.UltiSnipsJumpBackwardTrigger = "<C-h>"

		vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "my_snippets" }
	end,
}
