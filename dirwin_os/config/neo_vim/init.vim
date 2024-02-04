:set number
:set nowrap
:set mouse=a
:set smarttab
" :set tabstop=4
:set autoindent
" :set shiftwidth=4
:set softtabstop=4
:set relativenumber
:set clipboard+=unnamedplus
:set list
:set lcs+=space:·
:set autoindent noexpandtab tabstop=4 shiftwidth=4

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" :set guicursor=n-v-c-i:block

" :colorscheme jellybeans
" :colorscheme atom
" :colorscheme murphy

" Shortcut keys
nnoremap <C-s> :w<CR>
nnoremap <C-w> :q!<CR>
nnoremap <C-d> :q!<CR>
nnoremap <C-j> :term<CR>
nnoremap <C-z> :set wrap<CR>
nnoremap <C-k> :w<CR>:!comp %<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap :q :q!

inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i

inoremap " ""<Esc>i
inoremap ' ''<Esc>i
