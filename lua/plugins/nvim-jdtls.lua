return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local jdtls = require("jdtls")
		local home = os.getenv("HOME")
		local workspace_path = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		
		-- Find root of project
		local root_markers = { ".git", "mvnw", "gradlew", "build.gradle", "pom.xml" }
		local root_dir = require("jdtls.setup").find_root(root_markers)
		
		if root_dir == "" then
			return
		end

		local extendedClientCapabilities = jdtls.extendedClientCapabilities
		extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

		-- Try to find jdtls installation
		local jdtls_path = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
		
		-- If Mason jdtls is not found, try system installation
		if jdtls_path == "" then
			-- Try common system locations
			local system_paths = {
				"/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
				"/opt/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
			}
			
			for _, path in ipairs(system_paths) do
				local found = vim.fn.glob(path)
				if found ~= "" then
					jdtls_path = found
					break
				end
			end
		end
		
		-- If still not found, use the jdtls command directly
		local cmd
		if jdtls_path ~= "" then
			local config_path = home .. "/.local/share/nvim/mason/packages/jdtls/config_linux"
			-- Check if config exists, otherwise use system config
			if vim.fn.isdirectory(config_path) == 0 then
				config_path = "/usr/share/java/jdtls/config_linux"
			end
			
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens", "java.base/java.util=ALL-UNNAMED",
				"--add-opens", "java.base/java.lang=ALL-UNNAMED",
				"-jar", jdtls_path,
				"-configuration", config_path,
				"-data", workspace_path,
			}
		else
			-- Fallback to jdtls command if available
			cmd = { "jdtls", "-data", workspace_path }
		end

		local config = {
			cmd = cmd,
			root_dir = root_dir,
			
			settings = {
				java = {
					eclipse = {
						downloadSources = true,
					},
					configuration = {
						updateBuildConfiguration = "interactive",
					},
					maven = {
						downloadSources = true,
					},
					implementationsCodeLens = {
						enabled = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					format = {
						enabled = true,
						settings = {
							url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
							profile = "GoogleStyle",
						},
					},
				},
				signatureHelp = { enabled = true },
				completion = {
					favoriteStaticMembers = {
						"org.hamcrest.MatcherAssert.assertThat",
						"org.hamcrest.Matchers.*",
						"org.hamcrest.CoreMatchers.*",
						"org.junit.jupiter.api.Assertions.*",
						"java.util.Objects.requireNonNull",
						"java.util.Objects.requireNonNullElse",
						"org.mockito.Mockito.*",
					},
				},
				contentProvider = { preferred = "fernflower" },
				extendedClientCapabilities = extendedClientCapabilities,
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
			},

			flags = {
				allow_incremental_sync = true,
			},
			
			on_attach = function(client, bufnr)
				local _, _ = pcall(vim.lsp.codelens.refresh)
				
				-- Java-specific keymaps
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
				vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
				vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
				vim.keymap.set("v", "<leader>jm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
				vim.keymap.set("n", "<leader>jt", jdtls.test_class, opts)
				vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, opts)
				
				-- DAP
				jdtls.setup_dap({ hotcodereplace = "auto" })
				require("jdtls.dap").setup_dap_main_class_configs()
			end,
		}

		require("jdtls").start_or_attach(config)
	end,
}
