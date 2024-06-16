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
:set guicursor=n-v-c-i:block

call plug#begin() 
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
call plug#end()

" :colorscheme jellybeans
:colorscheme atom
" :colorscheme murphy

" Shortcut keys
nnoremap <C-s> :w<CR>
nnoremap <C-w> :q!<CR>
nnoremap <C-d> :q!<CR>
nnoremap <C-j> :term<CR>
nnoremap <A-z> :set wrap<CR>
" nnoremap <A-k> :w<CR>:!co %<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
