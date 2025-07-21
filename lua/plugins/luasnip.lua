return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		require("user.snips")
		local ls = require("luasnip")

		require("luasnip").config.setup({
			updateevents = "TextChanged,TextChangedI",
		})

		local M = {}

		function M.expand_or_jump()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end

		function M.jump_next()
			if ls.jumpable(1) then
				ls.jump(1)
			end
		end

		function M.jump_prev()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end

		function M.change_choice()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end

		function M.reload_package(package_name)
			for module_name, _ in pairs(package.loaded) do
				if string.find(module_name, "^" .. package_name) then
					package.loaded[module_name] = nil
					require(module_name)
				end
			end
		end

		function M.refresh_snippets()
			ls.cleanup()
			M.reload_package("user.snips")
		end

		local set = vim.keymap.set

		local mode = { "i", "s" }
		local normal = { "n" }

		-- set(mode, "<c-e>", M.expand_or_jump)
		-- set(mode, "<Right>", M.expand_or_jump)
		-- Tab is handled by nvim-cmp
		set(mode, "<c-n>", M.jump_prev)
		set(mode, "<c-l>", M.change_choice)
		-- set(normal, ",r", M.rlfresh_snippets)
		set(normal, "<leader>rls", M.refresh_snippets)
	end,
}
