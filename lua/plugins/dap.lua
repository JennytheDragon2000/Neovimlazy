return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup DAP UI
		dapui.setup()

		-- Setup virtual text
		require("nvim-dap-virtual-text").setup()

		-- DAP UI auto-open/close
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- DAP keymaps
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>da", function()
			dap.continue({ before = get_args })
		end, { desc = "Run with Args" })
		vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
		vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "Go to line (no execute)" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
		vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
		vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Session" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
		vim.keymap.set("n", "<leader>dw", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Widgets" })

		-- DAP UI keymaps
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })
	end,
}