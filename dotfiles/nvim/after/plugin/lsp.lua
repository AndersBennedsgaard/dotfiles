-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- installation of language servers
require("mason").setup({
  ensure_installed = {
    "prettierd",
    "stylua",
  },
})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "bashls",
    "yamlls",
    "marksman",
    "pyright",
    "ruff",
    "ts_ls",
  },
})

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
})

vim.lsp.config("ruff", {
  -- trace = 'messages',
  init_options = {
    settings = {
      -- logLevels = 'debug',
      lint = {
        ignore = { "CPY001", "DOC201" },
      },
      configurationPreference = "filesystemFirst",
    },
  },
})

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
