set langmenu=en_US.UTF-8
let $LANG='en_US'

let mapleader=" "
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nu
set nohlsearch
set hidden
set nowrap
set colorcolumn=80
set signcolumn=yes
set incsearch
set scrolloff=8
set noshowmode
set termguicolors
set encoding=UTF-8

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
"Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'

" HTML, CSS, JSON
" vscode-lsp requirements
Plug 'hrsh7th/vscode-langservers-extracted'
"}}}

" vscode snippet
" {{{
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

call plug#end()


let g:airline_theme = 'base16_chalk'
"  My Airline themes
"
"  base16_gruvbox_dark_hard, base_16_monokai, base16_pop,
"  dark_minimal, random, powerlineish, serene, tomorrow, wombat, zenburn

let g:airline_powerline_fonts = 1

" if exists('+termguicolors')
"     let &t_8f = !""\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b = !""\<Esc>[48;2;%lu;%lu;%lum"
" endif

colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard' "last value was medium
set background=dark

let g:material_style = 'deep ocean'
"colorscheme material

augroup asmprograms
    au BufRead,BufNewFile *.asm set filetype=masm
    au BufRead,BufNewFile *.inc set filetype=masm
augroup END

augroup htmlformat
    au BufRead,BufNewFile *.html set tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup yanking
    au TextYankPost * lua vim.highlight.on_yank { higroup="IncSearch", timeout=150, on_visual=true }
augroup END

set completeopt=menuone,noinsert,noselect

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'vim-vsnip'

" Add all the lsp servers from lua/lsp/*.lua
lua require('lsp')
lua require('indent')

noremap <C-z> <nop>
noremap + <nop>

noremap! ñ+ ~
noremap! ñ{ ^
noremap! ñ' \
noremap! ñ} `

" Bloques de quotes
" {{{
inoremap <A-}> ``<C-c>i
inoremap <A-"> ""<C-c>i
inoremap <A-'> ''<C-c>i
inoremap <A-(> ()<C-c>i
inoremap <A-{> {}<C-c>i
inoremap <A-[> []<C-c>i
inoremap <A-<> <><C-c>i
inoremap {<CR> {<CR>}<C-c>O
inoremap [<CR> [<CR>]<C-c>O
" }}}

vnoremap J :m '>+1'<CR>gv=gv
vnoremap K :m '<-2'<CR>gv=gv
vnoremap > >gv
vnoremap < <gv

" TELESCOPE MAPS
" {{{
nnoremap <leader>bf <cmd>Telescope buffers<CR>
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>gf <cmd>Telescope git_files<CR>
nnoremap <leader>fb <cmd>Telescope file_browser<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fr <cmd>Telescope grep_string<CR>
nnoremap <leader>fc <cmd>Telescope colorscheme<CR>
"}}}

" nvim-compe settings
" {{{
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat
" }}}

" vsnip Settings
" {{{
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
" let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.javascript = ['javascript']
" MAPS
"}}}
