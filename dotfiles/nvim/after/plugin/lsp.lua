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
  handler = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  },
})

local lsp = require("lspconfig")
lsp.lua_ls.setup({})
lsp.gopls.setup({})
lsp.bashls.setup({})
lsp.yamlls.setup({})
lsp.marksman.setup({
  single_file_support = true,
})
lsp.pyright.setup({
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
lsp.ruff.setup({
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
lsp.ts_ls.setup({})
-- lsp.nil_ls.setup({})
lsp.nixd.setup({
  cmd = { "nixd" }, -- installed by Nix
  settings = {
    nixd = {
      nixpkgs = { expr = "import <nixpkgs> { }" },
      formatting = { command = { "alejandra" } },
    },
  },
})
