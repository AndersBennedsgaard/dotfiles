require('illuminate').configure({
    providers = {
        "lsp",
        "treesitter",
    },

    delay = 100,
    under_cursor = false,
})

-- set illumintated work background color and remove underline
vim.cmd("highlight IlluminatedWordRead guibg = #525252 gui = NONE")
