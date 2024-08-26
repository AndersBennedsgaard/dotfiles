local lsp_zero = require("lsp-zero")

-- installation of language servers
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'gopls', 'bashls', 'yamlls', 'marksman', 'helm_ls', 'ruff' },
    automatic_installation = false,
    handlers = {
        lsp_zero.default_setup,
        marksman = function()
            require('lspconfig').marksman.setup({
                single_file_support = true,
            })
        end,
        ruff = function()
            require('lspconfig').ruff.setup({
                init_options = {
                    settings = {
                        lint = {
                            ignore = { "CPY001", "DOC201" }
                        },
                        configurationPreference = "filesystemFirst",
                    },
                },
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
