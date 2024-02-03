syntax on

if has('persistent_undo')               "check if your vim version supports
  set undodir=$HOME/.config/nvim/undo   "directory where the undo files will be stored
  set undofile                          "turn on the feature
endif

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
"set nu
set nowrap
set smartcase
set noswapfile
set novb
set nobackup
set incsearch
set showmatch
set laststatus=0
set mouse=a
set clipboard=unnamed
set clipboard=unnamedplus
set nocompatible
filetype plugin on

" remaps
let mapleader = " "
map q <Nop>
vnoremap <C-C> :w !xclip -i -sel c<CR><CR> 
" run current file
nnoremap <Leader>2 :w<CR>:!python3 %<CR>
