-- initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    version = "*"
  }
}

local plugins = {
  {
    'tpope/vim-sleuth',
    version = false,
  }, -- detect tabstop and shiftwidth automatically
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      version = false,
    },
  },
  { 'rose-pine/neovim',               name = 'rose-pine' },
  { 'nvim-treesitter/nvim-treesitter' },
  {
    'folke/lazydev.nvim',
    ft = "lua",
    opts = {},
  }, -- lsp support for NeoVim Lua
  {
    'numToStr/Comment.nvim',
    version = false,
    opts = {},
  },
  { 'stevearc/conform.nvim' },  -- Autoformat
  { 'mfussenegger/nvim-lint' }, -- Linters
  { 'airblade/vim-gitgutter' }, -- Git information in the gutter
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig', },            -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      {
        'hrsh7th/nvim-cmp',
        version = false,
      },                          -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 200,
      }
    }
  },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'RRethy/vim-illuminate' }, -- Highlight references
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
    }
  }
}

-- import plugins
require("lazy").setup(plugins, lazy_opts)
