local nvim_lsp = require('lspconfig')
local conf = require('lsp.lspConf')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local servers = { "pyright", "jdtls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = conf,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

require('lsp.langservs')
require('lsp.sumnekoConf')
