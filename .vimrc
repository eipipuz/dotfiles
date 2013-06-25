syntax on
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'git://github.com/kien/ctrlp.vim.git'
Bundle 'gmarik/vundle'
Bundle 'Syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'git://github.com/scrooloose/nerdtree.git'

filetype indent plugin on
filetype plugin on

set incsearch ignorecase hlsearch

set background=dark
colorscheme solarized
