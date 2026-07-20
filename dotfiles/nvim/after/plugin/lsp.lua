-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
  vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- These are installed via Nix
vim.lsp.enable({
  "lua_ls",
  "gopls",
  "bashls",
  "yamlls",
  "ts_ls",
})

vim.lsp.enable("marksman")
vim.lsp.config("marksman", {
  single_file_support = true,
})

vim.lsp.enable("nixd")
vim.lsp.config("nixd", {
  cmd = { "nixd" }, -- installed by Nix
  settings = {
    nixd = {
      nixpkgs = { expr = "import <nixpkgs> { }" },
      formatting = { command = { "alejandra" } },
    },
  },
})

vim.lsp.enable("ruff")
vim.lsp.config("ruff", {
  -- trace = 'messages',
  init_options = {
    settings = {
      -- logLevels = 'debug',
      configurationPreference = "filesystemFirst",
    },
  },
})

-- `ty` resolves its Python environment (.venv) relative to its project root
-- (LSP root_dir) only. In a uv workspace, only the workspace root has a .venv,
-- while member packages (e.g. lib/) only have a pyproject.toml.
-- Since nvim-lspconfig's default root_markers = {"ty.toml", "pyproject.toml", ".git"}
-- stops at the member package, prefer `uv.lock` (which only exists at the workspace root) to
-- land root_dir on the workspace root instead.
vim.lsp.enable("ty")
vim.lsp.config("ty", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, "uv.lock") or vim.fs.root(fname, { "ty.toml", "pyproject.toml", ".git" })
    on_dir(root)
  end,
  settings = {
    ty = {
      -- Report diagnostics for the entire workspace
      diagnosticMode = "workspace",
    },
  },
})
