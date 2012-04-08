syntax on

set t_Co=256
colorscheme wombat256

set autoindent
set nocompatible
set expandtab
set number
set showmatch
set smartcase
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=0
set smarttab
set hlsearch
set backspace=indent,eol,start
set modeline

set wildmenu
set wildchar=<Tab>
set wildmode=list:full

"nobackup noswap
set noswapfile
set nobackup
set writebackup

"カーソルのある行をハイライトする
set cursorline

set fileformats=unix,dos,mac
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
language message ja_JP.UTF-8

"ステータスラインを常に表示
set laststatus=2

"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:^\ ,trail:~

"入力中のコマンドをステータスに表示する
set showcmd

" syntaxオンで一行が長すぎると重い
set synmaxcol=500

" putty経由でもマウス
set mouse=a
set ttymouse=xterm2

" mapping
" ========================================
let mapleader = ","

noremap H :tabprevious<CR>
noremap L :tabnext<CR>

"xで削除した文字はレジスタに入れない
nnoremap x "_x

"USキーボード用
noremap ; :
noremap : ;

"Enterで改行
noremap <CR> o<ESC>

" ========================================
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
