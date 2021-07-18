-- nvim-compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

-- lsp python
require'lspconfig'.pyright.setup{}

-- lsp java
require'lspconfig'.jdtls.setup {
}

--[[
require'snippets'.use_suggested_mappings()

require'snippets'.snippets = {
    _global = {};
}
--]]
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

-- html lsp
require'lspconfig'.html.setup {
    cmd = { "vscode-html-language-server.cmd", "--stdio" },
    capabilities = capabilities,
}
-- css lsp
require'lspconfig'.cssls.setup {
    cmd = { "vscode-css-language-server.cmd", "--stdio" },
    capabilities = capabilities,
}
-- json lsp
require'lspconfig'.jsonls.setup {
    cmd = { "vscode-json-language-server.cmd", "--stdio" },
    filetypes = { "json" },
}

require'lsp.sumnekoConf'
