" http://github.com/echelon/dotfiles/blob/master/.vimrc

set nocompatible		" no vi bug compatibility
set modelines=0			" no modelines (for security)
"set encoding=utf-8		" encoding should be utf-8

set backup				" keep backup (~) files
"set nobackup 			" backup files removed when vim closes cleanly

"set backupdir=.,$HOME/.vim/backup	" backup file dir
"set directory=$HOME/.vim/swap 		" swapfile dir

filetype plugin indent on " filetype dependent indenting and plugins
set autoindent			" auto indents line relative to line above
set smartindent

set tabstop=4			" tab width preference
set shiftwidth=4		" tab width preference
"set expandtab			" uses spaces rather than tabs
set backspace=eol,start,indent " backspace over everything in insert mode
set smarttab 			" smarter tab and backspace

"set showmatch

syntax on				" highlighting
set background=dark		" dark background

set ttyfast				" smoother changes

set ruler				" show line stats at bottom
set number				" show line numbering

set columns=85			" vim is only 85 columns wide 
"set tw=79				" *force* margin at 79 characters
set wrap				" set wrapping text
set linebreak			" wordwrap so words aren't broken

set mouse=a				" mouse support in all modes
set mousehide			" hide mouse when typing text

set wildmode=longest:full	" bash-like autocomplete
set wildmenu				" bash-like autocomplete

set hidden				" allow editing multiple unsaved buffers

set browsedir=current	" use pwd

set shm=atAI			" shortmsg, ignore swapfiles, no intro

set t_Co=256			" Terminal supports 256 colors

set hlsearch			" Turn on search highlighting

if has("gui_running")
	" .gvimrc
	set guioptions-=T			" remove toolbar
	set guioptions-=m			" remove menu bar
	set guioptions-=b			" horizontal scrollbar
	colorscheme lucius2_transparent " gui colors 
else
	colorscheme lucius2_transparent " console colors
endif


" Python syntax highlighting
let python_highlight_all = 1
let python_slow_sync = 1

" Markdowk
au BufRead *.mkd set filetype=mkd


" Highlight text going beyond column 79
"highlight LenErr ctermbg=darkred ctermfg=white guibg=#592929
"highlight LenErr ctermbg=black ctermfg=yellow guibg=#592929
"match LenErr /\%>80v.*/ " Matches any over 80.


"set vb t_vb=
"set virtualedit=all


" No arrow keys in command mode! 
" This is a BAD HABBIT, and this should break me of it
map <Up> :<CR>
map <Down> :<CR>
map <Left> :<CR>
map <Right> :<CR>

" Keyboard Mappings
"map <F1> :previous<CR>	" open previous buffer
"map <F2> :next<CR>		" open next buffer

" Saving
map <C-s> :w<CR>				" save file

" Copy/paste from system clipboard
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>

:nmap <Leader>s :source $MYVIMRC<CR>	" resource vimrc
:nmap <Leader>v :e $MYVIMRC<CR>			" edit vimrc

" Open NERDtree plugin
map <C-f> :NERDTree<CR>

" New tab
map <C-t> :tabnew<CR>

" Movement between tabs OR buffers
nnoremap <C-j> :call MyNext()<CR>
nnoremap <C-k> :call MyPrev()<CR>
nnoremap <C-h> :call MyPrev()<CR>
nnoremap <C-l> :call MyNext()<CR>
nnoremap <C-n> :call MyNext()<CR>
nnoremap <C-p> :call MyPrev()<CR>
nnoremap <C-Right> :call MyNext()<CR>
nnoremap <C-Left> :call MyPrev()<CR>

" MyNext() and MyPrev(): Movement between tabs OR buffers
" Taken from: http://stackoverflow.com/questions/53664/
" how-to-effectively-work-with-multiple-files-in-vim 
function! MyNext()
	if exists( '*tabpagenr' ) && tabpagenr('$') != 1
		" Tab support && tabs open
		normal gt
	else
		" No tab support, or no tabs open
		execute ":bnext"
	endif
endfunction

function! MyPrev()
	if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
		" Tab support && tabs open
		normal gT
	else
		" No tab support, or no tabs open
		execute ":bprev"
	endif
endfunction

" Color scheme shifter plugin (F8 switches)
"source ~/.vim/plugin/setcolors.vim
"SetColors all


