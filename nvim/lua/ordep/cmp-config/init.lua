local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        [ '<C-d>' ] = cmp.mapping.scroll_docs(-4),
        [ '<C-f>' ] = cmp.mapping.scroll_docs(4),
        [ '<C-Space>' ] = cmp.mapping.complete(),
        [ '<C-e>' ] = cmp.mapping.close(),
        [ '<CR>' ] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'calc' },
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    formatting = {
        format = require("lspkind").cmp_format({
            with_text = true,
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                vsnip = "[vsnip]",
                path = "[Path]",
                calc = "[Calc]",
            }),
        }),
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

