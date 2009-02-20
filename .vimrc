colorscheme wombat

set autoindent
set nocompatible
set expandtab
set incsearch
set list
set number
set showmatch
set smartcase
set smartindent
set tabstop=4
set shiftwidth=4
set smarttab

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

au BufNewFile,BufRead * set tabstop=4 shiftwidth=4

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /ã/

noremap j 5j
noremap k 5k

noremap ; :
noremap : ;
