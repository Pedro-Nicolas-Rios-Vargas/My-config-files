local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap

local has_lsp, nvim_lsp = pcall(require, "lspconfig")
if not has_lsp then
    print("NEOVIM DOESN'T HAVE LSP PLUGGED IN")
    return
end

local custom_init = function (client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local filetype_attach = setmetatable({
    html = function(client)
        vim.cmd [[
            augroup lsp_buf_format
                au! BufWritePre <buffer>
                autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
            augroup END
        ]]
    end,
},{
    __index = function()
        return function() end
    end,
})

local buf_nnoremap = function(opts)
    opts.buffer = 0
    nnoremap(opts)
end

local buf_inoremap = function(opts)
    opts.buffer = 0
    inoremap(opts)
end

local custom_attach = function(client)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

    buf_nnoremap { "gd", vim.lsp.buf.definition }
    buf_nnoremap { "gD", vim.lsp.buf.declaration }
    buf_nnoremap { "gi", vim.lsp.buf.implementation }
    buf_nnoremap { "<C-k>", vim.lsp.buf.signature_help }
    buf_nnoremap { "<leader>D", vim.lsp.buf.type_definition }
    buf_nnoremap { "<leader>rn", vim.lsp.buf.rename }
    buf_nnoremap { "<leader>ca", vim.lsp.buf.code_action }
    buf_nnoremap { "gr", vim.lsp.buf.references }
    buf_nnoremap { "<leader>f", vim.lsp.buf.formatting }

    if filetype ~= "lua" then
        buf_nnoremap { "K", vim.lsp.buf.hover }
    end

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Attach any filetype specific options to the client
    filetype_attach[filetype](client)
end

--{{{
--Sumneko_lua thinks
local system_name
local sumneko_root_path
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
    sumneko_root_path = "/home/ordep/my_repositories/lua-language-server"
elseif vim.fn.has("win32") == 1 then
    system_name = "Windows"
    sumneko_root_path = "D:/pnrv2/Documents/Programas/lua/lua-language-server"
else
    print("Unsuported system for sumneko")
end

local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
--}}}

local filetypes = {
    javascript = "eslint",
    javascriptreact = "eslint",
    typescript = "eslint",
    typescriptreact = "eslint",
}

-- Other installed servers
-- denols
-- jdtls
-- pyright
-- tsserver
-- pylsp
local servers = {
    pylsp = true,
    jdtls = true,
    html = false,
    cssls = true,
    jsonls = false,
    sumneko_lua = {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    tsserver = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },
        on_attach = function (client)
            client.resolved_capabilities.document_formatting = false
            custom_attach(client)
        end
    },
    --diagnosticls = {
    --    filetypes = vim.tbl_keys(filetypes),
    --    init_options = {
    --        filetypes = filetypes,
    --        linters = {
    --            eslint = {
    --                sourceName = "eslint",
    --                command = "eslint_d",
    --                rootPatterns = { ".eslintrc.js", "package.json" },
    --                debounce = 100,
    --                args = {
    --                    "--stdin",
    --                    "--stdin-filename",
    --                    "%filepath",
    --                    "--format",
    --                    "json"
    --                },
    --                parseJson = {
    --                    errorsRoot = "[0].messages",
    --                    line = "line",
    --                    column = "column",
    --                    endLine = "endLine",
    --                    endColumn = "endColumn",
    --                    message = "${ message } [ ${ruleId} ]",
    --                    security = "severity"
    --                },
    --                securities = { [2] = "error", [1] = "warning" }
    --            }
    --        },
    --        formatters = {
    --            prettier = {
    --                command = "prettier",
    --                args = {
    --                    "--stdin-filepath",
    --                    "%filepath"
    --                }
    --            }
    --        },
    --        formatFiletypes = {
    --            javascript = "prettier",
    --            javascriptreact = "prettier",
    --            typescript = "prettier",
    --            typescriptreact = "prettier"
    --        }
    --    }
    --}

}

local setup_server = function (server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 50,
        },
    }, config)

    nvim_lsp[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = capabilities,
}
