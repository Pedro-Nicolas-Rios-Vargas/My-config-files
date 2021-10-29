vim.g.mapleader = " "

vim.cmd ('so ~/.config/nvim/vim_scripts/pluggins_vim-plug.vim')

vim.g.airline_theme = 'base16_chalk'

-- base16_gruvbox_dark_hard, base_16_monokai,
-- dark_minimal, random, powerlineish, serene, wombat

vim.g.airline_powerline_fonts = 1

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.material_style = 'deep ocean'
--vim.cmd[[colorscheme material]]
vim.cmd [[
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
]]

vim.cmd [[
augroup yanking
    au TextYankPost * lua vim.highlight.on_yank { higroup="IncSearch", timeout=150, on_visual=true }
augroup END
]]

vim.cmd [[runtime plugin/astronauta.vim]]
require "ordep.telescope"
require "ordep.cmp-config"
require "ordep.lsp"
require "ordep.indent"
--require "ordep.lspsaga"
require "ordep.treesitter"
