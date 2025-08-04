return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- LSP servers
				"typescript-language-server",
				"jdtls",
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				"lua-language-server",
				"emmet-ls",
				"pyright",
				-- Formatters and linters
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"java-debug-adapter", -- java debugger
				"java-test", -- java test runner
				"google-java-format", -- java formatter
				"checkstyle", -- java linter
			},
		})

		-- Note: LSP servers are configured in lspconfig.lua
	end,
}