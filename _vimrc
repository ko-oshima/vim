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
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'


filetype plugin indent on     " required!
filetype indent on
syntax on

" 入力中のコマンドを表示する
set showcmd
" タブ文字の表示幅
set tabstop=4
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

