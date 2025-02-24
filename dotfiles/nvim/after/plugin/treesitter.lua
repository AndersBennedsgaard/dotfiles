require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "go", "lua", "vim", "vimdoc", "query", "markdown" },

  -- Install parser synchronously
  sync_install = false,

  -- Autoinstall languages that are not installed
  auto_install = true,

  -- List of parsers to ignore installing
  ignore_install = {},

  modules = {},

  highlight = {
    enable = true,

    -- disable highligning for large files
    disable = function(_, buf)
      local max_filesize = 100 * 1024 * 1024 -- 100MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    additional_vim_regex_highlighting = false,
  },
})
