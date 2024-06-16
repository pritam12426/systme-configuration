:set autoindent expandtab tabstop=4 shiftwidth=4
:set autoread
:set ignorecase
:set iskeyword-=_
:set langmenu=en_US.UTF-8
:set mouse=a
:set nowrap
:set number
:set relativenumber
:set smartcase

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" :set guicursor=n-v-c-i:block

" --- theme ---
" :colorscheme jellybeans
" :colorscheme atom
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
