-- Replicates Neovim's default statusline ("%<%f %h%m%r%=%-14.(%l,%c%V%) %P")
-- with an added segment that warns when no treesitter parser is attached
-- to the current buffer.

function _G.TreesitterStatus()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype ~= "" then
    return ""
  end

  local parser = vim.treesitter.get_parser(buf)
  if parser then
    return ""
  end
  return "%#DiagnosticWarn# No TS parser%*"
end

vim.o.statusline = "%<%f %h%m%r %{%v:lua.TreesitterStatus()%}%=%y %-14.(%l,%c%V%) %P"
