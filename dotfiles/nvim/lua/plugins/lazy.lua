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

-- import plugins
require("lazy").setup({
  { 'tpope/vim-sleuth' }, -- detect tabstop and shiftwidth automatically
  { 'nvim-telescope/telescope.nvim',  dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'rose-pine/neovim',               name = 'rose-pine' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'folke/neodev.nvim',              opts = {} },
  { 'numToStr/Comment.nvim',          opts = {} },
  { 'stevearc/conform.nvim' }, -- Autoformat
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig', },            -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'RRethy/vim-illuminate' }, -- Highlight references
}, {})
