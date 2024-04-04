local lsp_zero = require("lsp-zero")

-- installation of language servers
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'gopls', 'bashls', 'pyright', 'yamlls', 'marksman' },
    automatic_installation = false,
    handlers = {
        lsp_zero.default_setup,
        marksman = function()
            require('lspconfig').marksman.setup({
                single_file_support = true,
            })
        end,
        pyright = function()
            require('lspconfig').pyright.setup({
                on_new_config = function(config, root_dir)
                    local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
                    if string.len(env) > 0 then
                        config.settings.python.pythonPath = env .. '/bin/python'
                    end
                end
            })
        end
    },
})

-- Fix Undefined global 'vim'
lsp_zero.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- mappings
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
    sources = {
        { name = 'nvim_lsp' }, -- autocompletion from LSPs
        { name = 'path' },     -- path autocompletion
        { name = 'buffer' },   -- extract suggestions from current buffer
    },
    mapping = cmp.mapping.preset.insert({
        ['<Cr>'] = cmp.mapping.confirm({ select = false }),

        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        -- Ctrl+up/down to scroll popup items
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
    }),
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = true
})
