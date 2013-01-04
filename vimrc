" https://github.com/echelon/dotfiles-vim

" ===== Behavior =====

set nocompatible		" no vi bug compatibility
set ttyfast				" smoother changes for fast terminal connection
set browsedir=current	" use pwd as current directory
set hidden				" allow editing multiple unsaved buffers
set mouse=a				" mouse support in all modes
set mousehide			" hide mouse when typing text
set backup				" keep backup (~) files
set directory=$HOME/.config/vim/swap " swapfile dir
set modelines=1			" okay, modelines (but bad security)
set wildmode=longest:full	" bash-like autocomplete
set wildmenu				" bash-like autocomplete
"set encoding=utf-8		" encoding should be utf-8
"set backupdir=.,$HOME/.config/vim/backup	" backup file dir

" ===== Editing =====

filetype plugin indent on " ft detection, plugins, indent plugins
set autoindent			" auto indents line relative to line above
set smartindent			" indent next line intelligently
set smarttab 			" smarter tab and backspace insert behavior
set ignorecase			" ignore case in search and replace
set smartcase			" case insensitive searching (requires ignorecase)
set tabstop=4			" number of spaces <Tab> represents
set shiftwidth=4		" number of spaces for autoindent >>
set foldmethod=indent	" create folds at indentation 
set backspace=eol,start,indent " backspace over everything in insert mode
set tw=79				" *force* margin at 79 characters
set wrap				" set wrapping text
set linebreak			" wordwrap nicely (words aren't broken, looks nice)
set textwidth=0			" don't automatically insert newlines on wrapped input
set wrapmargin=0		" don't automatically insert newlines on wrapped input
"set expandtab			" uses spaces rather than tabs
set noexpandtab

" ===== Appearance =====

syntax on				" highlighting (syntax)
set hlsearch			" highlighting (search term)
set number				" show line numbering
set ruler				" show line stats at bottom
set shm=atAI			" shortmsg abbrs, ignore swapfiles, no intro
set t_Co=256			" Terminal supports 256 colors
set background=dark		" dark background
set columns=80			" standard 80 columns wide (but resizes with window)

if has("gui_running")
	" .gvimrc
	set guioptions-=T			" remove toolbar
	set guioptions-=m			" remove menu bar
	set guioptions-=b			" horizontal scrollbar
	colorscheme dark_molokai	" gui colors 
	set term=screen-256color	" fix tmux(?)
else
	colorscheme dark_molokai	" console colors
endif

" ===== Extra File Extension Detection =====

au BufRead,BufNewFile *.{frag,vert,glsl,fp,vp} set filetype=glsl
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
au BufRead,BufNewFile *.rs set filetype=rust

" ===== File Type Tab Behavior =====

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2
au FileType coffee setl sw=2 sts=2 et
au FileType json setl sw=2 sts=2 et

" Python syntax highlighting
let python_highlight_all = 1
let python_slow_sync = 1

" Highlight text going beyond column 79
"highlight LenErr ctermbg=darkred ctermfg=white guibg=#592929
"highlight LenErr ctermbg=black ctermfg=yellow guibg=#592929
"match LenErr /\%>80v.*/ " Matches any over 80.

"set vb t_vb=
"set virtualedit=all

" ===== Keyboard Shortcuts / Bindings =====
" -- DOCUMENTATION -- 
" map	normal, visual, select, operator
" map!	insert, command
" Xmap	n:normal, i:insert, v:visual+select, s:select, 
" 		x:visual, c:command, o:operator

" Makes jk navigation work in wrapped text.
map j gj
map k gk
map ^ <Home>
map $ <End>

" New tab
map <C-t> :tabnew<CR>

" Movement between tabs OR buffers
" See MyNext(), MyPrev() below. 
" XXX: Removed. Going to try gt/gT from now on.
"nnoremap <C-j> :call MyNext()<CR>
"nnoremap <C-k> :call MyPrev()<CR>
"nnoremap <C-h> :call MyPrev()<CR>
"nnoremap <C-l> :call MyNext()<CR>
"nnoremap <C-Right> :call MyNext()<CR>
"nnoremap <C-Left> :call MyPrev()<CR>

" Saving
"map <C-s> :w<CR>

" HIGHLY OPINIONATED CHANGE --
" I hate that vim pastes at the cursor. I always want a newline
nmap p :pu<CR>

" Copy/paste from system clipboard
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" No arrow keys in command mode! 
" This is a BAD HABBIT, and this should break me of it
map <Up> :<CR>
map <Down> :<CR>
map <Left> :<CR>
map <Right> :<CR>

" Easy edit and re-source of vimrc
:nmap <Leader>s :source $MYVIMRC<CR>
:nmap <Leader>v :e $MYVIMRC<CR>

" Open NERDtree plugin
"map <C-f> :NERDTree<CR>

" I hate vim help. It's close to the escape key.
map <F1> :<CR>
map! <F1> <Left><Right>

" Toggle spelling
map <F5> :set spell! spelllang=en_us<CR>

" Switch colorschemes
map <F9> :call NextColor(-1)<CR>
map <F10> :call NextColor(1)<CR>

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

let g:solarized_termcolors=256
let g:solarized_termtrans=0
let g:solarized_background='light' "Only want light version
let g:solarized_visibility='high'

" Color scheme shifter plugin (F8 switches)
source ~/.config/vim/plugin/setcolors.vim
"SetColors all

