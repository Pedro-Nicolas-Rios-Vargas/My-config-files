local on_attach = require('lsp.lspConf')
local capabilities = require('lsp.capabilities')

-- html lsp
require'lspconfig'.html.setup {
    cmd = { "vscode-html-language-server.cmd", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    }
}
-- css lsp
require'lspconfig'.cssls.setup {
    cmd = { "vscode-css-language-server.cmd", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    }
}
-- json lsp
require'lspconfig'.jsonls.setup {
    cmd = { "vscode-json-language-server.cmd", "--stdio" },
    filetypes = { "json" },
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    init_options = {
        provideFormatter = true
    }
}

