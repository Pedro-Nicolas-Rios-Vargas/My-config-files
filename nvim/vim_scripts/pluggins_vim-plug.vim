call plug#begin('~/.nvim/plugged')

" indent decorator

Plug 'lukas-reineke/indent-blankline.nvim'

" colorscheme
" {{{
Plug 'gruvbox-community/gruvbox'
Plug 'marko-cerovac/material.nvim'
" }}}

" LSP
" {{{
" lsp requirements
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
"Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

" HTML, CSS, JSON
" vscode-lsp requirements
Plug 'hrsh7th/vscode-langservers-extracted'

"}}}

" vscode snippet
" {{{
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
" }}}

" telescope pluggins
" {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'ap/vim-css-color'
" }}}

" Neovim bar decorator
" {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" }}}

Plug 'tjdevries/astronauta.nvim'

call plug#end()
