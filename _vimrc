set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'

" 単語補完
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1
NeoBundle 'violetyk/neocomplete-php.vim'
let g:neocomplete_php_locale = 'ja'
" 最初に :PhpMakeDict ja で辞書を作成する。

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-singleton'
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'


filetype plugin indent on     " required!
filetype indent on
syntax on

" 入力中のコマンドを表示する
set showcmd
" タブ文字の表示幅
set tabstop=4
set shiftwidth=4
" 行番号を表示
set number

" 文字コード設定
set encoding=utf-8

" バックアップファイルの設定
set backup
set backupdir=~/tmp/vim

" swapファイルの設定
set swapfile
set directory=~/tmp/vim

"" タブの設定 ---
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
map <silent> [Tag]u :Ut<CR>

"" タブの設定 ここまで---


" php保存時にphpunitを実行する
" テスト対象と同じディレクトリにテストファイルがあることが
" 条件になっているので要改良
function! s:runPhpunit()
	    let fileName = expand("%:r") . "Test.php"
		if filereadable(fileName)
			" ファイルが存在する場合のみテストを実行する	
			exe "!phpunit --colors " . fileName
		endif
endfunction

function! s:checkPHP()
	let filePath = expand('%:p')
	exe "!php -l " . filePath
endfunction

autocmd BufWritePost *.{php} call <SID>runPhpunit()
autocmd BufWritePost *.{php} call <SID>checkPHP()


" backspace の有効化
set backspace=start,eol,indent

set encoding=sjis

set fileencodings=iso-2022-jp,cp932,euc-jp,utf-8

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set iminsert=0
set imsearch=0

set nowrap
command Ut Unite file -tab

" netrwは常にtree view
let g:netrw_liststyle = 3
" " CVSと.で始まるファイルは表示しない
" let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" " 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" " 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1



"" vim を一つのタブで起動する
call singleton#enable()

