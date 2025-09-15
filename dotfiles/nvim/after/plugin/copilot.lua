vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.g.copilot_filetypes = {
  ['*'] = false,
  ['javascript'] = true,
  ['typescript'] = true,
  ['typescriptreact'] = true,
  ['javascriptreact'] = true,
  ['lua'] = true,
  ['python'] = true,
  ['go'] = true,
  ['rust'] = true,
  ['c'] = true,
  ['cpp'] = true,
  ['java'] = true,
  ['html'] = true,
  ['css'] = true,
  ['nix'] = true,
  ['markdown'] = true,
}
