return {
	"jannis-baum/vivify.vim",
	ft = { "markdown" }, -- Load only for markdown files
	config = function()
		-- Enable instant refresh on text changes (default: 1)
		vim.g.vivify_instant_refresh = 1
		
		-- Enable auto-scroll in viewer (default: 1)
		vim.g.vivify_auto_scroll = 1
		
		-- Additional filetypes to recognize as markdown (optional)
		-- vim.g.vivify_filetypes = { "vimwiki" }
	end,
}
