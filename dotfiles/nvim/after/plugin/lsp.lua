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

-- Auto-detect python from .venv in project root
local function get_python_path(workspace)
  local venv = workspace .. "/.venv/bin/python"
  if vim.fn.executable(venv) == 1 then
    return venv
  end
  return vim.fn.exepath("python3") or "python3"
end

vim.lsp.config("pyright", {
  on_init = function(client)
    -- print("Pyright client config:", vim.inspect(client.config))
    local workspace = client.config.root_dir or vim.fn.getcwd()
    client.config.settings.python.pythonPath = get_python_path(workspace)
    client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end,

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
      configurationPreference = "filesystemFirst",
    },
  },
})

vim.lsp.config("ty", {
  settings = {
    ty = {
      -- Prefer Pyright for language server features (code completion, go to definition, etc.)
      -- Only use Ty for type checking
      disableLanguageServices = true,
      -- Report diagnostics for the entire workspace
      diagnosticMode = "workspace",
    },
  },
})
vim.lsp.enable("ty")
