set autoindent expandtab tabstop=4 shiftwidth=4
set autoread
set ignorecase
set iskeyword-=_
set langmenu=en_US.UTF-8
set mouse=a
set nowrap
set number
set relativenumber
set shell=bash

autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

" let mapleader=","
" map <leader>y "*y

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter
set gdefault                      " have :s///g flag by default on

" --- theme ---
:colorscheme murphy

" Shortcut keys
" For normal mode
nnoremap <C-c> :set clipboard=unnamedplus<CR>
nnoremap :q :q!

nnoremap x "_x
vnoremap x "_x

" For insert mode
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i
