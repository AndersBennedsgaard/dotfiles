require("conform").setup({
  notify_on_error = false,
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {},
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports-reviser" },
    python = { "ruff_fix" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    yaml = { "prettierd" },
  },
})
