-- Native tree-sitter setup

-- Filetypes without their own grammar, reusing another language's parser/queries.
vim.treesitter.language.register("hcl", "terraform")
vim.treesitter.language.register("bash", "sh")

-- Start tree-sitter highlighting for any filetype whose parser is installed,
-- whatever the source (nix, manually compiled, etc). No per-filetype list to
-- maintain: new parsers just start working automatically.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match) or args.match
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})
