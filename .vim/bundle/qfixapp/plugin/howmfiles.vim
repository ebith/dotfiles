"=============================================================================
"    Description: HowmTitlelist for QFixHowm
"         Author: fuenor <fuenor@gmail.com>
"  Last Modified: 2011-02-08 17:40
"        Version: 1.01
"=============================================================================
if exists('loaded_HowmFiles') && !exists('fudist')
  finish
endif
let loaded_HowmFiles=1

if v:version < 700
  finish
endif

if !exists('g:HowmFiles_Sort')
  let g:HowmFiles_Sort = ''
endif

augroup HowmFiles
  au!
  autocmd CursorHold  __Howm_Files__ call <SID>Preview()
  autocmd BufWinEnter __Howm_Files__ call <SID>BufWinEnter(g:QFix_PreviewEnable)
  autocmd BufLeave    __Howm_Files__ call <SID>BufLeave()
augroup END

function! s:Preview()
  if b:PreviewEnable < 1
    return
  endif

  let [file, lnum] = s:Getfile('.')
  call QFixPreviewOpen(file, lnum)
endfunction

function! s:BufWinEnter(preview)
  let b:updatetime = g:QFix_PreviewUpdatetime
  exec 'setlocal updatetime='.b:updatetime
  let b:PreviewEnable = a:preview

  nnoremap <buffer> <silent> I :<C-u>call <SID>TogglePreview()<CR>
  nnoremap <buffer> <silent> i :<C-u>call <SID>TogglePreview()<CR>
  nnoremap <buffer> <silent> D :<C-u>call <SID>Cmd_RD('Delete')<CR>
  nnoremap <buffer> <silent> R :<C-u>call <SID>Cmd_RD('Remove')<CR>
  nnoremap <buffer> <silent> S :<C-u>call <SID>SortExec()<CR>
  nnoremap <buffer> <silent> s :<C-u>call <SID>Search('g!')<CR>
  nnoremap <buffer> <silent> r :<C-u>call <SID>Search('g')<CR>
  nnoremap <buffer> <silent> u :<C-u>call <SID>Exec('undo')<CR>
  nnoremap <buffer> <silent> <C-r> :<C-u>call <SID>Exec("redo")<CR>

  nnoremap <buffer> <silent> <C-w>h     :QFixAltWincmd h<CR>
  nnoremap <buffer> <silent> <C-w>j     :QFixAltWincmd j<CR>
  nnoremap <buffer> <silent> <C-w>k     :QFixAltWincmd k<CR>
  nnoremap <buffer> <silent> <C-w>l     :QFixAltWincmd l<CR>
  nnoremap <buffer> <silent> <C-w><C-h> :QFixAltWincmd h<CR>
  nnoremap <buffer> <silent> <C-w><C-j> :QFixAltWincmd j<CR>
  nnoremap <buffer> <silent> <C-w><C-k> :QFixAltWincmd k<CR>
  nnoremap <buffer> <silent> <C-w><C-l> :QFixAltWincmd l<CR>

  nnoremap <buffer> <silent> q :close<CR>
  nnoremap <buffer> <silent> <CR> :<C-u>call <SID>CR()<CR>

  syn match	qfFileName	"^[^|]*" nextgroup=qfSeparator
  syn match	qfSeparator	"|" nextgroup=qfLineNr contained
  syn match	qfLineNr	"[^|]*" contained contains=qfError
  syn match	qfError		"error" contained

  " The default highlighting.
  hi def link qfFileName	Directory
  hi def link qfLineNr	LineNr
  hi def link qfError	Error

  silent exec 'lchdir ' . escape(g:howm_dir, ' ')

endfunction

function! s:TogglePreview()
  let b:PreviewEnable = !b:PreviewEnable
  let g:QFix_PreviewEnable = b:PreviewEnable
  setlocal nowinfixheight
  pclose!
  setlocal winfixheight
endfunction

function! s:BufLeave()
  let s:lnum = line('.')
endfunction

let g:HowmFilesMode = 0
let s:lnum = 1
function! QFixHowmListAllTitleAlt(...)
  let g:HowmFilesMode = 0
  cclose
  let defsort = 0
  if !exists('s:glist') || a:0
    let defsort = 1
    let pattern = escape(g:QFixHowm_Title, g:QFixHowm_EscapeTitle)
    if !exists('g:mygrepprg') || g:mygrepprg == 'internal' || g:mygrepprg == ''
      let pattern = '^'. pattern . '\(\s\|$\)'
    elseif g:mygrepprg == 'findstr'
      let pattern = '^'. pattern . '[ \t]'
    else
      let pattern = '^'. pattern . '([ 	]|$)'
    endif
    let addflag = 0
    redraw|echo 'HowmFiles : Searching...'
    let prevPath = getcwd()
    let prevPath = escape(prevPath, ' ')
    silent exec 'lchdir ' . escape(g:howm_dir, ' ')
    call MyGrep(pattern, g:howm_dir, g:QFixHowm_SearchHowmFile, g:howm_fileencoding, addflag, 'noqfix')
    if !exists('g:mygrepprg') || g:mygrepprg == 'internal' || g:mygrepprg == ''
      let s:glist = []
      let qflist = getqflist()
      for n in qflist
        let bufnum = n['bufnr']
        let filename = fnamemodify(bufname(bufnum), ':.')
        let line = printf("%s|%d|%s", filename, n['lnum'], n['text'])
        call add(s:glist, line)
      endfor
    elseif g:howm_fileencoding == g:MyGrep_ShellEncoding && g:howm_fileencoding == &enc
      let s:glist = []
    else
      let s:glist = []
      for n in g:MyGrep_qflist
    "    let n['filename'] = g:howm_dir . '/' . n['filename']
        let line = printf("%s|%d|%s", n['filename'], n['lnum'], n['text'])
        call add(s:glist, line)
      endfor
      let s:glist = reverse(s:glist)
    endif
    silent exec 'lchdir ' . prevPath
    let s:lnum = 1
  endif

  let file = g:howm_dir.'/__Howm_Files__'
  let mode = 'split'
  call QFixEditFile(file, mode)
  silent exec 'lchdir ' . escape(g:howm_dir, ' ')
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  setlocal nowrap
  setlocal cursorline
  setlocal winfixheight
  wincmd J

  setlocal modifiable
  silent! %delete _
  if s:glist == []
    silent! 0put=g:MyGrep_retval
    silent! %s/:\(\d\+\):/|\1|/
    silent! $delete _
  else
    call setline(1, s:glist)
  endif
  call cursor(s:lnum, 1)
  if exists("*QFixHowmListAllTitleAltPost")
    call QFixHowmListAllTitleAltPost()
  endif
  setlocal nomodifiable

  silent exec 'lchdir ' . escape(g:howm_dir, ' ')
  let g:QFix_SearchPath = g:howm_dir
  if defsort && g:HowmFiles_Sort != ''
    call s:SortExec(g:HowmFiles_Sort)
  endif
  nnoremap <buffer> <silent> i :<C-u>call <SID>TogglePreview()<CR>
endfunction

function! s:CR()
  let [file, lnum] = s:Getfile('.')
  call QFixEditFile(file)
  call cursor(lnum, 1)
endfunction

function! s:Getfile(lnum)
  let l = a:lnum
  let file = substitute(getline(l), '|.*$', '', '')
  if !filereadable(file)
    let file = g:howm_dir.'/'.file
  endif
  let lnum = matchstr(getline(l), '|\d\+\( col \d\+\)\?|')
  let lnum = matchstr(lnum, '\d\+')
  if lnum==''
    let lnum = 1
  endif
  let pfile = g:howm_dir.'/'.file
  if !filereadable(pfile)
    let pfile = fnamemodify(file, ':p')
  endif
  return [pfile, lnum]
endfunction

function! s:SortExec(...)
  let mes = 'Sort type? (r:reverse)+(m:mtime, n:name, t:text) : '
  if a:0
    let pattern = a:1
  else
    let pattern = input(mes, '')
  endif
  if pattern =~ 'r\?m'
    let g:QFix_Sort = substitute(pattern, 'm', 'mtime', '')
  elseif pattern =~ 'r\?n'
    let g:QFix_Sort = substitute(pattern, 'n', 'name', '')
  elseif pattern =~ 'r\?t'
    let g:QFix_Sort = substitute(pattern, 't', 'text', '')
  elseif pattern == 'r'
    let g:QFix_Sort = 'reverse'
  else
    return
  endif

  echo 'HowmFiles : Sorting...'
  let sq = []
  for n in range(1, line('$'))
    let [pfile, lnum] = s:Getfile(n)
    let text = substitute(getline(n), '[^|].*|[^|].*|', '', '')
    let mtime = getftime(pfile)
    let sepdat = {"filename":pfile, "lnum": lnum, "text":text, "mtime":mtime}
    call add(sq, sepdat)
  endfor

  if g:QFix_Sort =~ 'mtime'
    let sq = s:Sort(g:QFix_Sort, sq)
  elseif g:QFix_Sort =~ 'name'
    let sq = s:Sort(g:QFix_Sort, sq)
  elseif g:QFix_Sort =~ 'text'
    let sq = s:Sort(g:QFix_Sort, sq)
  elseif g:QFix_Sort == 'reverse'
    let sq = reverse(sq)
  endif
  silent exec 'lchdir ' . escape(g:howm_dir, ' ')
  let s:glist = []
  for d in sq
    let filename = fnamemodify(d['filename'], ':.')
    let line = printf("%s|%d|%s", filename, d['lnum'], d['text'])
    call add(s:glist, line)
  endfor
  setlocal modifiable
  silent! %delete _
  call setline(1, s:glist)
  setlocal nomodifiable
  call cursor(1,1)
  redraw|echo 'Sorted by '.g:QFix_Sort.'.'
endfunction

function! s:Sort(cmd, sq)
  if a:cmd =~ 'mtime'
    let sq = sort(a:sq, "s:QFixCompareTime")
  elseif a:cmd =~ 'name'
    let sq = sort(a:sq, "s:QFixCompareName")
  elseif a:cmd =~ 'text'
    let sq = sort(a:sq, "s:QFixCompareText")
  endif
  if g:QFix_Sort =~ 'r.*'
    let sq = reverse(a:sq)
  endif
  let g:QFix_SearchResult = []
  return sq
endfunction
function! s:QFixCompareName(v1, v2)
  if a:v1.filename == a:v2.filename
    return (a:v1.lnum > a:v2.lnum?1:-1)
  endif
  return ((a:v1.filename) . a:v1.lnum> (a:v2.filename) . a:v2.lnum?1:-1)
endfunction
function! s:QFixCompareTime(v1, v2)
  if a:v1.mtime == a:v2.mtime
    if a:v1.filename != a:v2.filename
      return (a:v1.filename < a:v2.filename?1:-1)
    endif
    return (a:v1.lnum > a:v2.lnum?1:-1)
  endif
  return (a:v1.mtime < a:v2.mtime?1:-1)
endfunction
function! s:QFixCompareText(v1, v2)
  if a:v1.text == a:v2.text
    return (a:v1.filename < a:v2.filename?1:-1)
  endif
  return (a:v1.text > a:v2.text?1:-1)
endfunction

function! s:Cmd_RD(cmd)
  let [file, lnum] = s:Getfile('.')
  if a:cmd == 'Delete'
    let mes = "!!!Delete : ".file
  else
    let mes = "!!!Remove to (~howm_dir) : ".file
  endif
  let choice = confirm(mes, "&Yes\n&Cancel", 2, "W")
  if choice != 1
    return
  endif
  let dst = substitute(file, '.*/', escape(g:howm_dir, ' ').'/', '')
  let dst = expand(dst)
  if a:cmd == 'Delete'
    call delete(file)
  else
    call rename(file, dst)
  endif
endfunction

function! s:Exec(cmd)
  let mod = &modifiable ? '' : 'no'
  setlocal modifiable
  exec a:cmd
  exec 'setlocal '.mod.'modifiable'
endfunction

function! s:Search(cmd, ...)
  if a:0
    let _key = a:1
  else
    let mes = a:cmd == 'g' ? '(exclude)' : ''
    let _key = input('Search for pattern'.mes.' : ')
    if _key == ''
      return
    endif
  endif
  let @/=_key
  call s:Exec(a:cmd.'/'._key.'/d')
  call cursor(1, 1)
  call QFixPclose()
endfunction

function! SetHowmFiles(glist)
  let file = g:howm_dir.'/__Howm_Files__'
  let mode = 'split'
  call QFixEditFile(file, mode)
  silent exec 'lchdir ' . escape(g:howm_dir, ' ')
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  setlocal nowrap
  setlocal cursorline
  setlocal winfixheight
  wincmd J

  setlocal modifiable
  silent! %delete _
  call setline(1, a:glist)
  " setlocal nomodifiable

  silent exec 'lchdir ' . escape(g:howm_dir, ' ')
  let g:QFix_SearchPath = g:howm_dir
endfunction
