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

imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>

filetype on
filetype indent on
filetype plugin on

"nobackup noswap
set noswapfile
set nobackup

"再読込、vim終了後も継続するアンドゥ(7.3)
if version >= 703
  "Persistent undoを有効化(7.3)
  set undofile
  "アンドゥの保存場所(7.3)
  set undodir=./.vimundo,~/.vimundo
endif

syntax on

"全角スペースをハイライトする
scriptencoding utf-8
function! ZenkakuSpace()
  "ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
  highlight ZenkakuSpace cterm=underline ctermbg=white gui=underline guibg=white
  "全角スペースを明示的に表示する。
  silent! match ZenkakuSpace /　/
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd VimEnter,BufEnter * call ZenkakuSpace()
  augroup END
endif


"USキーボード用
noremap ; :
noremap : ;

"Enterで改行
noremap <CR> o<ESC>

"カーソルのある行をハイライトする
set cursorline

set fileformats=unix,dos,mac
set enc=utf-8
set fileencodings=utf-8,cp932,euc-jp

"copypath.vim
"無名レジスタにもコピーデータを入れる
let g:copypath_copy_to_unnamed_register = 1

"xで削除した文字はレジスタに入れない
noremap x "_x
noremap dd "_dd
let g:yankring_n_keys = 'Y D'

"ステータスラインを常に表示
set laststatus=2
"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:^\ ,trail:~
"入力中のコマンドをステータスに表示する
set showcmd

" neocomplcache
let g:neocomplcache_enable_at_startup  = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_quick_match = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><CR>  (pumvisible() ? "\<C-y>":'') . "\<C-f>\<CR>X\<BS>"
inoremap <expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

" yankring.vim
let g:yankring_history_file = '.yankring_history'
