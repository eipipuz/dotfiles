syntax on
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-bufferline'
Plugin 'junegunn/goyo.vim'
Plugin 'majutsushi/tagbar'
" Go plugins
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
" Unite
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/vimproc.vim', {'build': {'mac': 'make'}}

call vundle#end()

set rtp+=/usr/local/Cellar/go/1.1.1/misc/vim/

filetype indent plugin on
filetype plugin on

set incsearch ignorecase hlsearch relativenumber

if $COLOR_THEME == "Solarized Dark"
	set background=dark
"	highlight ColorColumn ctermbg=darkblue
else
	set background=light
"	highlight ColorColumn ctermbg=lightgray
endif
let g:solarized_termtrans = 1
colorscheme solarized

set shiftwidth=2 tabstop=2

let g:ycm_path_to_python_interpreter = "/usr/local/bin/python"

augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\<nl>\"|$
	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\<nl>\"|$
augroup END

autocmd BufNewFile *.factor 0put=\"! Copyright (C) 2013 Guillermo Alcantara\<nl>! See http://factorcode.org/license.txt for BSD license.\<nl>USING:  ;\<nl>IN: \"|$

set expandtab
set softtabstop=2

autocmd FileType python set tabstop=4|set shiftwidth=4|set softtabstop=4
autocmd FileType javascript set tabstop=2|set shiftwidth=2
autocmd FileType go set noexpandtab|set tabstop=4|set shiftwidth=4|set softtabstop=4

let g:ctrlp_custom_ignore = { 'dir': '\.git$', 'file': '\.pyc$' }
let g:jedi#use_tabs_not_buffers = 0

set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<
" Normal backspace mode
set bs=2

" Draws a line on position 101 as a reminder of long lines
let &colorcolumn="101"

" Makes airline be always visible
set laststatus=2
" Prevents duplicating the buffer list in the command line and airline
let g:bufferline_echo = 0
" Fancy symbols for airline
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_section_x = 0
let g:airline_section_y = 0
let g:airline_theme = 'base16'

" Prevent vim from capturing the selection from the mouse
set mouse-=a

" Change leader to spacebar
let mapleader = "\<space>"

" format go with goimports
let g:go_fmt_command = "goimports"

" Mixing syntastic with vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Buffer shortcuts
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>/ :nohls<CR>
nnoremap <leader>z <c-w>z
autocmd FileType go nnoremap <leader>a :GoAlternate<CR>
" Reload file (used when editing .vimrc)
autocmd FileType vim nnoremap <leader>r :so %<CR>
" Git shortcuts
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>gl :Gcommit -v -a<CR>
nnoremap <leader>gm :Gcommit -v -a --amend<CR>
nnoremap <leader>gn :Gcommit -v -a --amend --no-edit<CR>
nnoremap <leader>gs :Gstatus<CR>

" Unite setup
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
    \ '-i --vimgrep --hidden --ignore ' .
    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''
nnoremap <silent> <c-p> :Unite -auto-resize -start-insert file_mru file_rec<CR>
nnoremap <leader>l :Unite -auto-resize -start-insert -buffer-name=buffer  buffer<CR>
nnoremap <leader>f :Unite -auto-resize -start-insert -buffer-name=ag  grep:.<CR>
nnoremap <leader>* :UniteWithCursorWord line<CR>
nnoremap <leader>g :UniteWithCursorWord grep:.<CR>

" Gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
