vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.g.copilot_filetypes = {
  ['*'] = true,
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", "local.settings.json" },
  callback = function()
    vim.b.copilot_enabled = false
  end,
})
