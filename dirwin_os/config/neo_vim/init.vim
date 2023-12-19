" I use vim Plug for my package manager for nvim.
" :PlugInstall

:set number
:set nowrap
" :set mouse=a
:set smarttab
:set tabstop=4
:set autoindent
:set shiftwidth=4
:set softtabstop=4
:set relativenumber
" :set guicursor=n-v-c-i:block

" :colorscheme jellybeans
" :colorscheme atom
" :colorscheme murphy

" Shortcut keys
nnoremap <C-s> :w<CR>
nnoremap <C-w> :q!<CR>
nnoremap <C-d> :q!<CR>
nnoremap <C-j> :term<CR>
nnoremap <A-z> :set wrap<CR>
" nnoremap <A-k> :w<CR>:!co %<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
