local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" }, -- autocompletion from LSPs
    { name = "path" }, -- path autocompletion
    { name = "buffer" }, -- extract suggestions from current buffer
  },
  mapping = cmp.mapping.preset.insert({
    ["<Cr>"] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+up/down to scroll popup items
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),

    -- Ctrl+space to trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})

vim.diagnostic.config({
  virtual_text = true,
})
