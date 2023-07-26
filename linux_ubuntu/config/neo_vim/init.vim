" I use vim Plug for my package manager for nvim.
" :PlugInstall

:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set nowrap
" :set mouse=a

call plug#begin() 
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
call plug#end()

:colorscheme jellybeans

" Shortcut keys
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-j> :term<CR>
nnoremap <A-k> :w<CR>:!comp %<CR>
nnoremap <C-w> :q!<CR>
nnoremap <C-s> :w<CR>

