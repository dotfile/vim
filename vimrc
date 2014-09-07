" Brandon Thomas' vimrc etc.
" An opinionated vim config.
" https://github.com/echelon/dotfiles-vim
" web: http://brand.io 
" mail: bt at brand.io
 
" TODO: massive cleanup (ongoing as of 2014-09-01)

" ======================================================================
" VUNDLE PACKAGE MANAGEMENT FOR VIMSCRIPT, COLORS, FTDETECT, ETC.
" ======================================================================

" Vundle Notes: 
" Source vimrc, then call :PluginInstall to install/update plugins.
" Use ! to force reinstallation of all bundles. 
" Also, :PluginClean

  filetype on  " Must toggle so Mac doesn't return nonzero exit code.
  filetype off " (Only use Macs for work...)

  set rtp +=~/.vim/bundle/Vundle.vim " Runtime path
  call vundle#begin()

  " ===== Vundle Plugins =====
    Plugin 'gmarik/Vundle.vim'
    Plugin 'bkad/CamelCaseMotion'
    Plugin 'terryma/vim-smooth-scroll'
    Plugin 'elzr/vim-json'

  call vundle#end()
  filetype plugin indent on " ft detection, plugins, indent plugins

" ======================================================================
" CORE VIM CONFIGURATION OPTIONS
" ======================================================================

" Vim Core Configuration Notes:
" Use `:help 'directive'` for manpage (use single quotes to disambiguate).
" Use `:set directive?` to introspect current value.

  " ===== Core =====
  set nocompatible		    " This is vim. No ancient vi bug compatability.
  set hidden				      " Allow editing multiple unsaved buffers (duh)
  set encoding=utf-8		  " Encoding should be utf-8
  set ttyfast				      " Smoother for fast terminal connections
  set wim=longest:full    " [wildmode] Bash-like autocomplete
  set wildmenu				    " Bash-like autocomplete

  " ===== Filesystem / Backups =====
  set backup				      " Keep backup (~) files
  set browsedir=current	  " Use pwd as current directory
  set backupdir=.,$HOME/.config/vim/backup  " Backup file dirs (in order)
  set directory=$HOME/.config/vim/swap      " Swapfile dir
  set wildignore+=*~      " Don't tab complete these files
  set wig+=*.pyc,*.pyo    " (continued)
  set wig+=*.o            " (continued)

  " ===== Mode Behaviors =====
  set modelines=1			    " What was this ?? - (bad security - ??)
  set backspace=eol       " I-mode: backspace over EOL to join lines
  set backspace+=indent   " I-mode: backspace over autoindentation
  set backspace+=start    " I-mode: backspace over start of insert

  " ===== Spacing, Tabs, and Indenting =====
  set expandtab			      " Use spaces instead of tabs (work convinced me)
  set tabstop=2			      " Number of spaces <Tab> represents
  set shiftwidth=2	      " Number of spaces for autoindent (>>)
  set autoindent		      " Auto indents line relative to line above
  set smartindent		      " Indent next line intelligently
  set smarttab 			      " Smarter tab and backspace insert behavior

  " ===== Text Wrapping, Margin =====
  set tw=79				        " Force margin at 79 characters
  set wrap				        " Wrap text
  set linebreak			      " Wrap nicely (words aren't broken, looks nice)
  set textwidth=0			    " No auto insert of newlines on wrapped input
  set wrapmargin=0		    " No auto insert of newlines on wrapped input

  " ===== Code Folding =====
  set foldmethod=indent	  " Create folds at indentation 
  set foldlevelstart=20	  " Starting fold level when opening files

  " ===== Search and Replace =====
  set ignorecase			    " Ignore case in search and replace
  set smartcase			      " Case insensitive searching (requires ignorecase)
  set hlsearch			      " Highlighting of search term

  " ===== Colors and Appearance =====
  syntax on				        " Syntax Highlighting
  colo dark_molokai_t	    " Molokai is the bestest evar!!1
  set background=dark	    " Dark background
  set t_Co=256			      " Terminal supports 256 colors
  set title				        " Change the terminal title
  set number			        " Show line numbering
  set ruler				        " Show line stats at bottom
  set shm=atAI			      " Shortmsg abbrs, ignore swapfiles, no intro
  set columns=80			    " Std 80 cols wide (but resize with window)
  set laststatus=0		    " No status line!
  "set rulerformat=%-14.(%c%V%)\ %P " Don't need line number

  " ===== Super Lame Gui Mode =====

  if has("gui_running")
    " Why would you ever run from a gui? 
    " Such torture. Much disappoint.
    " Also Consider : ~/.gvimrc
    set mousehide			    " Hide mouse when typing text
    set guioptions-=T			" Remove toolbar
    set guioptions-=m			" Remove menu bar
    set guioptions-=b			" Horizontal scrollbar
    set term=screen-256color	" fix tmux(?)
    colorscheme dark_molokai	" gui colors 
  else
    "set mouse=a			" mouse support in all modes
  endif



" TODO: All of this is a disorganized mess. 

" ======================================================================
" CUSTOM BINDINGS, SCRIPTING, OVERRIDES, AND MISC CARGO-CULTED VIMSCRIPT
" ======================================================================

" Notes On Functions: 
" Suffix ! denotes redeclaration is idempotent (ie. file reloaded)
" Function name must normally start with uppercase.
" Provide local scope with prefix `s:`; needn't be uppercase.
"
" Notes On Key Remapping:
" map	normal, visual, select, operator
" map!	insert, command
" Xmap	n:normal, i:insert, v:visual+select, s:select, 
" 		x:visual, c:command, o:operator

" Vim Tabs: ============================================================

  " Open tab to left of current.
  " From : http://stackoverflow.com/a/13275945
  command! -nargs=* -bar TabnewL :execute (tabpagenr()-1).'tabnew '.<q-args>

  " Movement between tabs OR buffers.
  " From : http://stackoverflow.com/a/83984
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

  " Open new tabs
  map <C-t> :tabnew<CR>
  map <C-w> :TabnewL<CR>

  " XXX: Removed. Going to use gt/gT from now on.
  "nnoremap <C-j> :call MyNext()<CR>
  "nnoremap <C-k> :call MyPrev()<CR>
  "nnoremap <C-h> :call MyPrev()<CR>
  "nnoremap <C-l> :call MyNext()<CR>
  "nnoremap <C-Right> :call MyNext()<CR>
  "nnoremap <C-Left> :call MyPrev()<CR>

" Text Navigation And Movements: =======================================

  " Makes jk navigation work in wrapped text.
  map j gj
  map k gk
  map ^ g^
  map $ g$

  " The default "CamelCaseMotion" keys
  map ,w <Plug>CamelCaseMotion_w
  map ,b <Plug>CamelCaseMotion_b
  map ,e <Plug>CamelCaseMotion_e

  " IntelliJ has pseudo-CamelCaseMotion keys (match them)
  map [w <Plug>CamelCaseMotion_w
  map [b <Plug>CamelCaseMotion_b
  map [e <Plug>CamelCaseMotion_e

  " Disable "Beginner Mode" (the only way to learn)
  " No Arrow Keys in Command Mode! 
  map <Up> :<CR>
  map <Down> :<CR>
  map <Left> :<CR>
  map <Right> :<CR>

" Status Line: =========================================================

  " Show/hide statusline.
  function! StatusLineHide() 
    set laststatus=0
  endfunction

  function! StatusLineShow() 
    set laststatus=2
  endfunction

  " Kind of exhaustive to toggle status lines...
  " Not covering all cases here.
  nnoremap i :call StatusLineShow()<Esc>i
  nnoremap I :call StatusLineShow()<Esc>I
  nnoremap a :call StatusLineShow()<Esc>a
  nnoremap A :call StatusLineShow()<Esc>A
  nnoremap v :call StatusLineShow()<Esc>v
  nnoremap V :call StatusLineShow()<Esc>V

  " Extra <CR> to clear command line
  inoremap <Esc> <Esc>:call StatusLineHide()<CR>:<CR><Esc>
  vnoremap <Esc> <Esc>:call StatusLineHide()<CR>:<CR><Esc>

" Pasting And Buffer: ==================================================

  " HIGHLY OPINIONATED CHANGE, YOU PROBABLY WON'T LIKE IT.
  " I hate that vim pastes at the cursor. I always want a newline.
  nmap p :pu<CR>

  " Copy/paste from system clipboard
  " Requires `xclip` binary.
  vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
  nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
  imap <C-v> <esc>:call setreg("\"",system("xclip -o -selection clipboard"))<CR>pi

" Ungrouped Stuff: =====================================================

  " Remove current search term/state
  " TODO: Make sure I didn't override a function
  nmap t :let @/ = ""<CR><CR>

  " Saving
  "map <C-s> :w<CR>

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

  " Color scheme shifter plugin (F8 switches)
  source ~/.config/vim/plugin/setcolors.vim
  "SetColors all

  " Custom Fold Text
  " From http://stackoverflow.com/questions/
  " 5983396/change-the-text-in-folds
  function! MyFoldText()
      let numLines = v:foldend - v:foldstart + 1
      let linetext = substitute(getline(v:foldstart),"^ *","",1)
      let txt = '+ ' . numLines . ' lines '
      return txt
  endfunction
  "set foldtext=MyFoldText()

" ======================================================================
" SCRIPT AND COLORSCHEME CONFIGURATIONS
" ======================================================================

  let g:solarized_termcolors=256
  let g:solarized_termtrans=0
  let g:solarized_background='light' "Only want light version
  let g:solarized_visibility='high'

  " Python syntax highlighting specifics
  let python_highlight_all = 1
  let python_slow_sync = 1

" ===== Extra File Extension Detection =====

  au BufRead,BufNewFile *.{frag,vert,glsl,fp,vp} set filetype=glsl
  au BufRead,BufNewFile *.json set filetype=json
  au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=md
  au BufRead,BufNewFile *.rs set filetype=rust

" ===== File Type Tab Behavior =====

  "autocmd FileType html setlocal shiftwidth=2 tabstop=2
  "autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
  "autocmd FileType json setlocal shiftwidth=2 tabstop=2

  " Syntaxes with 2 Spaces
  au FileType coffee setl sw=2 sts=2 et
  au FileType html setl sw=2 sts=2 et
  au FileType jinja setl sw=2 sts=2 et
  au FileType json setl sw=2 sts=2 et

  " Syntaxes with Tabs
  "au FileType python setl sw=4 sts=4 noet
  "au FileType python setlocal expandtab shiftwidth=4 softtabstop=4
  au FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4

" ===== Remove Any Unused Cruftiness =====

  " Highlight text going beyond column 79
  "highlight LenErr ctermbg=darkred ctermfg=white guibg=#592929
  "highlight LenErr ctermbg=black ctermfg=yellow guibg=#592929
  "match LenErr /\%>80v.*/ " Matches any over 80.

  "set vb t_vb=
  "set virtualedit=all
