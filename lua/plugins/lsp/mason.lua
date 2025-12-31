return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- import shared LSP configuration
		local lsp_config = require("core.lsp-config")

		-- import lspconfig
		local lspconfig = require("lspconfig")

		-- Get capabilities from shared config
		local capabilities = lsp_config.get_capabilities()

		-- Setup diagnostic signs
		lsp_config.setup_diagnostics()

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

	mason_lspconfig.setup({
		-- list of servers for mason to install
		ensure_installed = {
			"ts_ls",
			"jdtls",
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"emmet_ls",
			"pyright",
		},
		-- Disable automatic_enable feature (requires Neovim 0.11+, we use handlers instead)
		automatic_enable = false,
		-- handlers for automatic LSP server configuration
		handlers = {
			-- Default handler for most servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = lsp_config.on_attach,
				})
			end,

			-- Exclude jdtls from automatic setup (configured separately in nvim-jdtls.lua)
			["jdtls"] = function() end,

			-- Custom handler for emmet_ls with custom filetypes
			["emmet_ls"] = function()
				lspconfig.emmet_ls.setup({
					capabilities = capabilities,
					on_attach = lsp_config.on_attach,
					filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
				})
			end,

			-- Custom handler for lua_ls with vim globals and workspace settings
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					on_attach = lsp_config.on_attach,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								-- make language server aware of runtime files
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				})
			end,
		},
	})

		mason_tool_installer.setup({
			ensure_installed = {
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

		-- Note: jdtls is configured separately in nvim-jdtls.lua for better integration
	end,
}
