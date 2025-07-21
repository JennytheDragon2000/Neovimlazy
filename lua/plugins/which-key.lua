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
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
      },
    })
    
    -- Register key groups for better organization
    wk.register({
      ["<leader>f"] = { name = "Find/Telescope" },
      ["<leader>g"] = { name = "Git" },
      ["<leader>h"] = { name = "Git Hunks" },
      ["<leader>l"] = { name = "LSP" },
      ["<leader>s"] = { name = "Split/Session" },
      ["<leader>t"] = { name = "Toggle/Terminal" },
      ["<leader>x"] = { name = "Trouble/Diagnostics" },
      ["<leader>b"] = { name = "Buffer" },
      ["<leader>r"] = { name = "Replace/Rename" },
      ["<leader>c"] = { name = "Code/ChatGPT" },
      ["<leader>j"] = { name = "Java" },
    })
  end,
}
