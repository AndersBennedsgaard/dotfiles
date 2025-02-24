-- initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
  defaults = {
    -- Use latest stable plugin version for plugins that support SemVer
    -- If plugins have old releases but we require newer commits, set 'version = false'
    version = "*",
  },
}

local plugins = {
  { -- detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    version = false,
  },
  { -- fuzzy finder
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      version = false,
    },
  },
  { -- rose-pine theme
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { "nvim-treesitter/nvim-treesitter" },
  { -- lsp support for NeoVim Lua
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  { -- improved comment manipulation
    "numToStr/Comment.nvim",
    version = false,
    opts = {},
  },
  { "stevearc/conform.nvim" }, -- Autoformat
  { "mfussenegger/nvim-lint" }, -- Linters
  { "airblade/vim-gitgutter" }, -- Git information in the gutter
  { "neovim/nvim-lspconfig" }, -- LSP support
  { "williamboman/mason.nvim" }, -- Package manager for LSPs, DAPs, linters, and formatters
  { "williamboman/mason-lspconfig.nvim" }, -- Mason extension for LSPs
  { -- Autocompletion engine for LSPs, and others
    "hrsh7th/nvim-cmp",
    version = false,
  },
  { "hrsh7th/cmp-nvim-lsp" }, -- nvim-csp plugin to autocomplete based on LSP capabilities
  { "hrsh7th/cmp-path" }, -- nvim-csp plugin to autocomplete paths
  { "hrsh7th/cmp-buffer" }, -- nvim-csp plugin to autocomplete words in the buffer
  { "L3MON4D3/LuaSnip" }, -- Snippet engine
  { -- Zen mode
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 200,
      },
    },
  },
  { "RRethy/vim-illuminate" }, -- Highlight references
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = true,
    opts = {
      log_level = "DEBUG",
    },
  },
}

-- import plugins
require("lazy").setup(plugins, lazy_opts)
