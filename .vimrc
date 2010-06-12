colorscheme wombat
if g:colors_name ==? 'wombat'
      hi Visual gui=none guifg=khaki guibg=olivedrab
endif

syntax on

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
set modeline

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

au BufNewFile,BufRead * set tabstop=4 shiftwidth=4

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /ã/

noremap ; :
noremap : ;

set fileformats=unix,dos,mac
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,euc-jp
