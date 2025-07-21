return {
    "EdenEast/nightfox.nvim",
    lazy = false, -- Load during startup since it's the main colorscheme
    priority = 1000, -- Load before other plugins
    config = function()
        vim.cmd([[colorscheme terafox]])
        -- Visual selection colors are now handled in basic-settings.lua to avoid duplication
    end,
}
