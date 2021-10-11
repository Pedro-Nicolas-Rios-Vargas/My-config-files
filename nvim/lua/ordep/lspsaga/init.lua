local nnoremap = vim.keymap.nnoremap

local saga = require 'lspsaga'

saga.init_lsp_saga()

-- Async Lsp Finder
nnoremap { "<silent> gh", "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>" }

-- Actions
nnoremap { "<silent><leaden>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>" }
nnoremap { "<silent><leaden>ca", "<cmd>lua require('lspsaga.codeaction').range_code_action()<CR>" }

-- Hover Doc
nnoremap { "<silent> K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>" }
nnoremap { "<silent> <C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>" }
nnoremap { "<silent> <C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>" }

-- Signature
nnoremap { "<silent> gs", "<cmd>lua require('lspsaga.signaturehelp').signaturehelp()<CR>" }

-- Rename/Refactor
nnoremap { "<silent> gr", "<cmd>lua require('lspsaga.rename').rename()<CR>" }

-- Preview Def
nnoremap { "<silent> gd", "<cmd>lua require('lspsaga.provider').preview_definition()<CR>" }

-- Jump Diagnostic
nnoremap { "<silent><leader>cd", "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>" }
nnoremap { "<silent> [e", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>" }
nnoremap { "<silent> ]e", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>" }
