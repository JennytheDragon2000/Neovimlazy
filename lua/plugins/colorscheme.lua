return {

    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme terafox]])
        vim.cmd("hi Visual ctermfg=NONE ctermbg=Brown cterm=NONE")
        vim.cmd("hi Visual guifg=NONE guibg=Brown gui=NONE")
    end,

} -- lazy
