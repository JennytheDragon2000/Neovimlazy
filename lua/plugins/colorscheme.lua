return {
    "EdenEast/nightfox.nvim",
    lazy = false, -- Load during startup since it's the main colorscheme
    priority = 1000, -- Load before other plugins
    config = function()
        vim.cmd([[colorscheme terafox]])
        -- Visual selection colors are now handled in basic-settings.lua to avoid duplication
        
        -- Beautiful Git Signs colors
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#50C878", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FFA500", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#FF6B6B", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#FF6B6B", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#FFA500", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#87CEEB", bold = true })
        
        -- Staged signs colors
        vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = "#98FB98", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#FFCC99", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = "#FFB6C1", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsStagedTopdelete", { fg = "#FFB6C1", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsStagedChangedelete", { fg = "#FFCC99", bold = true })
        
        -- Number highlighting for git changes (makes line numbers colored)
        vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#50C878", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#FFA500", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#FF6B6B", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { fg = "#FF6B6B", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { fg = "#FFA500", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsUntrackedNr", { fg = "#87CEEB", bold = true })
    end,
}
