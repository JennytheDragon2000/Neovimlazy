return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      win = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
      },
    })
    
    -- Register key groups for better organization
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code/ChatGPT" },
      { "<leader>f", group = "Find/Telescope" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>j", group = "Java" },
      { "<leader>l", group = "LSP" },
      { "<leader>r", group = "Replace/Rename" },
      { "<leader>s", group = "Split/Session" },
      { "<leader>t", group = "Toggle/Terminal" },
      { "<leader>x", group = "Trouble/Diagnostics" },
    })
  end,
}
