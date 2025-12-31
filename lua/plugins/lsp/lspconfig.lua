return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- LSP servers are configured automatically via mason-lspconfig handlers
		-- See lua/plugins/lsp/mason.lua for server configurations
		-- Shared LSP settings (on_attach, capabilities, signs) are in lua/core/lsp-config.lua
	end,
}
