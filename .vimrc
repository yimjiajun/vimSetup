 " be iMproved, required
set nocompatible
filetype on
filetype indent on

colorscheme industry "buildin type
	set t_Co=256 " support 256 bits color
	set background=dark " tell vim what color on background
	set encoding=UTF-8
	set wildmenu " command line popup
	" set splitright
	set splitbelow
syntax enable
	" set expandtab " placed tab as whitespace
	set number relativenumber
	set ignorecase
	set smartcase
	set showmatch " show match parenthese () {} []
	set hidden
	if has('persistent_undo')         "check if your vim version supports
		set undodir=$HOME/.vim/undo     "directory where the undo files will be stored
		set undofile                    "turn on the feature
	endif
	set wrap
	set linebreak
	set cursorline
set noshowmode
set autoindent " follow last coloumn indent
	set ts=2 " tab indent 4 whitespace
	set sw=2
	" details : https://samwhelp.github.io/note-about-vim/read/adjustment/view/cursor-line/advance-cursor-line.html
	au InsertLeave * set cursorline nocursorcolumn
	au InsertEnter * set nocursorline nocursorcolumn
	au WinEnter * set cursorline nocursorcolumn
	au WinLeave * set nocursorline nocursorcolumn
" set path=** " find" to only type file name

set nobackup
set nowritebackup

" =============================
" Format
" =============================
autocmd FileType c,cpp setlocal cindent ts=4  sw=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Show trailing whitepace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
	" kill trailing whitespace
	autocmd BufWritePre * :%s/\s\+$//e
	if has('win32')
		" kill carriage-return from DOS/window system
		autocmd BufWritePre * :%s///e
	endif

augroup Binary
	au!
	au BufReadPre  *.bin let &bin=1
	au BufReadPost *.bin if &bin | %!xxd
	au BufReadPost *.bin set ft=xxd | endif
	au BufWritePre *.bin if &bin | %!xxd -r
	au BufWritePre *.bin endif
	au BufWritePost *.bin if &bin | %!xxd
	au BufWritePost *.bin set nomod | endif
augroup END

set timeoutlen=500
let g:mapleader = "<Space>"
let g:maplocalleader = ','
" =============================
" keys-mapping
" =============================
" first character
" - 'i' : insert mode
" - 'n' : normal mode
" <ESC> : alias key
" ----------------------
" Move
" ----------------------
	inoremap <silent><c-j> <CR>
	inoremap <silent><c-b> <Left>
	inoremap <silent><c-f> <Right>
	inoremap <silent><esc>b <c-o>b
	inoremap <silent><esc>f <c-o>w
" ----------------------
" Window
" ----------------------
	nnoremap <silent><s-h> <C-w>h
	nnoremap <silent><s-l> <C-w>l
	nnoremap <silent><c-s> :w<CR>
" ----------------------
" Buffer
" ----------------------
	nnoremap <silent><S-Tab> :bprevious<CR>
	nnoremap <silent><Tab> :bnext<CR>
	nnoremap <silent><C-c> :bdelete<CR>
" ----------------------
" Quick Fix
" ----------------------
	nnoremap <silent><Space>tQ :copen<CR>
	nnoremap <silent><Space>tq :cclose<CR>
" ----------------------
" View
" ----------------------
	nnoremap <silent><BS> :set hlsearch!<CR>
" ----------------------
" Edit
" ----------------------
	inoremap <silent><c-s> <c-o>:w<CR>
	inoremap <silent><c-d> <del>
	inoremap <silent><c-h> <c-o>X
	inoremap <silent>lkj <esc>
	tnoremap <silent>lkj <c-\><c-n>
	tnoremap <silent>\][ <c-c>exit<CR>
	inoremap <silent>"" ""<esc>i
	inoremap <silent>'' ''<esc>i
	inoremap <silent>{} {}<esc>i
	inoremap <silent>() ()<esc>i
	inoremap <silent>(<CR> (<CR>)<c-o>O
	inoremap <silent>{<CR> {<CR>}<c-o>O
	inoremap <silent>[<CR> [<CR>]<c-o>O
	inoremap <silent>"<CR> "<CR>"<c-o>O
	inoremap <silent>'<CR> '<CR>'<c-o>O
" ----------------------
" Yank
" ----------------------
"	nnoremap <silent>x "_x
"	nnoremap <silent>X "_X
	vnoremap <silent>x "_x
	vnoremap <silent>X "_X
	vnoremap <silent>p "_dP

" ----------------------
" browser
" ----------------------
if has('macunix')
	nnoremap <silent>gx :silent execute '!open ' . shellescape('<cWORD>') <CR>
else
	nnoremap <silent>gx :silent execute '!xdg-open ' . shellescape('<cWORD>') <CR>
endif

" ----------------------
" Session
"-----------------------
" =============================
" cscope setting
" =============================
if has("cscope")
	" add any cscope database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add the database pointed to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	"   'a'   assigment: find assigments to this symbols
	nmap <silent><Space>fca :cs find a <C-R>=expand("<cword>")<CR><CR>
	"   's'   symbol: find all references to the token under cursor
	nmap <silent><Space>fcs :cs find s <C-R>=expand("<cword>")<CR><CR>
	"   'g'   global: find global definition(s) of the token under cursor
	nmap <silent><Space>fcg :cs find g <C-R>=expand("<cword>")<CR><CR>
	"   'c'   calls:  find all calls to the function name under cursor
	nmap <silent><Space>fcc :cs find c <C-R>=expand("<cword>")<CR><CR>
	"   't'   text:   find all instances of the text under cursor
	nmap <silent><Space>fct :cs find t <C-R>=expand("<cword>")<CR><CR>
	"   'e'   egrep:  egrep search for the word under cursor
	nmap <silent><Space>fce :cs find e <C-R>=expand("<cword>")<CR><CR>
	"   'f'   file:   open the filename under cursor
	nmap <silent><Space>fcf :cs find f <C-R>=expand("<cfile>")<CR><CR>
	"   'i'   includes: find files that include the filename under cursor
	nmap <silent><Space>fci :cs find i <C-R>=expand("<cfile>")<CR><CR>
	"   'd'   called: find functions that function under cursor calls
	nmap <silent><Space>fcd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

if filereadable("ecfw-zephyr/build.sh")
	set makeprg=cd\ $(west\ topdir)/$(west\ config\ manifest.path)\ &&\ ./build.sh
elseif filereadable(".west")
	set makeprg=cd\ $(west\ topdir)/$(west\ config\ manifest.path)\ &&\ west\ build\ -p=always
endif
