" Windowsでも$HOME/.vimがいい
if has('win32') || has('win64')
  " Reset, prepend ~/.vim and add ~/.vim/after to runtimepath
  set runtimepath& runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after

  " Normalize $PATH to unix style
  let $PATH = substitute($PATH, "\\", "/", "g")
endif

" pathogen.vim
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt

filetype plugin indent on
syntax on

set t_Co=256
colorscheme wombat256
if g:colors_name ==? 'wombat256'
  hi Visual gui=none guifg=khaki guibg=olivedrab
endif


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

" for Windows
set backupcopy=yes

"再読込、vim終了後も継続するアンドゥ(7.3)
if version >= 703
  "Persistent undoを有効化(7.3)
  set undofile
  "アンドゥの保存場所(7.3)
  set undodir=~/.vimundo
endif

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

"カーソルのある行をハイライトする
set cursorline

set fileformats=unix,dos,mac
set enc=utf-8
set fileencodings=utf-8,cp932,euc-jp

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

" .viminfo
set viminfo+=n~/.viminfo

" help引いたらフリーズする
set notagbsearch

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

" plugin
" ========================================
" neocomplcache
let g:neocomplcache_enable_at_startup  = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" yankring.vim
" let g:yankring_history_file = '.yankring_history'
" let g:yankring_n_keys = 'Y D'

" Unite
let g:unite_enable_start_insert=1
noremap <Leader>ub :Unite buffer -default-action=tabopen<CR>
noremap <Leader>uu :Unite buffer file_mru -default-action=tabopen<CR>
noremap <Leader>ue :Unite -buffer-name=files buffer file_mru everything -default-action=tabopen<CR>
noremap <Leader>ur :Unite -buffer-name=register register<CR>
noremap <Leader>uh :Unite help:ja<CR>
noremap <Leader>uc :Unite history/command<CR>
noremap <Leader>us :Unite history/search<CR>

noremap t :Unite buffer file_mru -default-action=tabopen<CR>
noremap T :Unite -buffer-name=files buffer file_mru everything -default-action=tabopen<CR>

" howm
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding = 'utf-8'
let howm_fileformat = 'unix'
if has('win32') || has('win64')
  let howm_dir = 'C:\dropbox/document/howm'
  let mygrepprg = 'C:/bin/Cygwin/bin/grep'
  let $CYGWIN = 'nodosfilewarning'
elseif has('mac')
  let howm_dir = '~/Dropbox/document/howm'
  let mygrepprg = 'grep'
  let MyGrep_ShellEncoding = 'utf-8'
endif
