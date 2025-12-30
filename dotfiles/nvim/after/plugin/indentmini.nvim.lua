local indentmini = require("indentmini")
indentmini.setup() -- use default settings

-- Indent line highlight
vim.cmd.highlight('IndentLine guifg=#384240')
-- Current indent line highlight
vim.cmd.highlight('IndentLineCurrent guifg=#123456')
