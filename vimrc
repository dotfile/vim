" The Vim Configs Of Brandon Thomas:
" These are a little bit opinionated. They're primarily designed for
" Linux, but try to work for my workpace Mac too. Not much thought is
" given to GUI usage. I typically edit HTML, Python, JS, C++, etc., so
" these formats drive most of the evolution here.
"   - web: http://brand.io
"   - mail: bt at brand.io | echelon at gmail
"   - git: https://github.com/echelon/dotfiles-vim

" TABLE OF CONTENTS:
"   [1] Vundle Packages
"   [2] Core Vim Configuration
"   [3] Filetype-specific Configs
"   [4] Plugin-specific Config Overrides
"   [5] Custom Scripting and Key Bindings

" TODO: Restore some of the following things I removed:
"   - indent/ Indentation processing (css, coffee, etc.)
"   - syntax/ (C, Cpp, Lua, Markdown, OpenGL, Bash, Awk...)
"   - plugin/ (python_editing, setcolors)
"   - ftdetect/ (misc)

" TODO: Write a plugin or autowrapping on key-bindings. Support
" comments strings, various syntaxes. Like IntelliJ's Ctrl+L.
" Global var for wrap length, but also movement-based override.

" ======================================================================
" [1] VUNDLE PACKAGE MANAGEMENT FOR VIMSCRIPT, COLORS, FTDETECT, ETC.
" ======================================================================

" Vundle Notes:
" Source vimrc, then call :PluginInstall to install/update plugins.
" Use ! to force reinstallation of all bundles.
" Also, :PluginClean

  filetype on  " Must toggle so Mac doesn't return nonzero exit code.
  filetype off " (Only use Macs for work...)

  set rtp +=~/.vim/bundle/Vundle.vim " Runtime path
  call vundle#begin()
    Plugin 'gmarik/Vundle.vim'

  " ===== Plugins =====
    Plugin 'bkad/CamelCaseMotion'       " Motions inside camel/snake case
    Plugin 'scrooloose/nerdtree'        " File tree navigation sidebar
    Plugin 'terryma/vim-smooth-scroll'  " Smooth scrolling (kind of nice)

  " ===== Plugins to Try Later =====
    "Plugin 'kien/ctrlp'                 " File, history, etc. finder
    "Plugin 'scrooloose/syntastic'       " Syntax error highlighting
    "Plugin 'tpope/vim-fugitive'         " Git wrapper
    "Plugin 'tpope/vim-surround'         " Tags, parens, quotes, etc.
    "Plugin 'felixhummel/setcolors'      " Function to change colorscheme

  " ===== Syntax =====
    Plugin 'cespare/vim-toml'
    Plugin 'elzr/vim-json'
    Plugin 'groenewege/vim-less'
    Plugin 'leafgarland/typescript-vim'
    Plugin 'mustache/vim-mustache-handlebars'
    Plugin 'rust-lang/rust.vim'
    Plugin 'tikhomirov/vim-glsl'
    Plugin 'uarun/vim-protobuf'

    "Plugin 'beyondmarc/glsl.vim' (alt, evolution of the one I used)

  call vundle#end()
  filetype plugin indent on " ft detection, plugins, indent plugins

" ======================================================================
" [2] CORE VIM CONFIGURATION OPTIONS
" ======================================================================

" Vim Core Configuration Notes:
" Use `:help 'directive'` for manpage (use single quotes to disambiguate).
" Use `:set directive?` to introspect current value.

  " ===== Core =====
  set nocompatible		    " This is vim. No ancient vi bug compatability.
  set hidden				      " Allow editing multiple unsaved buffers (duh)
  set encoding=utf-8		  " Encoding should be utf-8
  set modelines=0			    " Don't load other people's modelines
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
  "set columns=80			    " Std 80 cols wide (but resize with window)
  set synmaxcol=200       " No highlight beyond col (bad *MLs!)
  set laststatus=0		    " No status line!
  set cursorline          " Highlight the line the cursor is on
  "set rulerformat=%-14.(%c%V%)\ %P " Don't need line number

  " ===== Super Lame Gui Mode =====

  if has("gui_running")
    " Why would you choose to run vim inside a gui? Such sad.
    " Consider putting config garbage here instead: ~/.gvimrc
    set mousehide			    " Hide mouse when typing text
    set guioptions-=T			" Remove toolbar
    set guioptions-=m			" Remove menu bar
    set guioptions-=b			" Horizontal scrollbar
    set term=screen-256color	" fix tmux(?)
    colorscheme dark_molokai	" gui colors
  else
    "set mouse=a			" mouse support in all modes
  endif

" ======================================================================
" [3] FILETYPE-SPECIFIC CONFIGURATION
" ======================================================================

  " Syntaxes with 2 spaces, no tabs.
  au FileType coffee setl sw=2 sts=2 et
  au FileType css setl sw=2 sts=2 et
  au FileType html setl sw=2 sts=2 et
  au FileType json setl sw=2 sts=2 et
  au FileType rust setl sw=2 sts=2 et

  " Syntaxes with 4 spaces, no tabs.
  au FileType python setl sw=4 sts=4 et

  " Remove line-ending whitespace.
  au BufWritePre *.cpp :%s/\s\+$//e
  au BufWritePre *.hpp :%s/\s\+$//e
  au BufWritePre *.js :%s/\s\+$//e
  au BufWritePre *.py :%s/\s\+$//e

  " There's no registered extension for GLSL?
  au BufRead,BufNewFile *.{frag,vert,glsl,fp,vp} set filetype=glsl

" ======================================================================
" [4] PLUGIN CONFIG OVERRIDES
" ======================================================================

  " Solarized (I don't us it often)
  let g:solarized_termcolors=256
  let g:solarized_termtrans=0
  let g:solarized_background='light' "Only want light version
  let g:solarized_visibility='high'

  " Python syntax highlighting specifics
  let python_highlight_all = 1
  let python_slow_sync = 1

  " It's so silly that the JSON syntax plugin hides quotes!
  let g:vim_json_syntax_conceal = 0

" ======================================================================
" [5] CUSTOM BINDINGS, SCRIPTING, OVERRIDES, AND CARGO-CULTED VIMSCRIPT
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
  "
  " Yet More Notes:
  " Wrap your vimscript with \ after the newline.

" Vimrc Editing: =======================================================

  " Easy edit and re-source of vimrc
  :nmap <Leader>v :e $MYVIMRC<CR>
  :nmap <Leader>s :source $MYVIMRC<CR>

" Disable Stupid Things: ===============================================

  " Disable "Beginner Mode" (newbies: this is the only way to learn!)
  map <Up> :<CR>
  map <Down> :<CR>
  map <Left> :<CR>
  map <Right> :<CR>

  " I hate vim help. It's close to the escape key.
  map <F1> :<CR>
  map! <F1> <Left><Right>

" Tabs: ================================================================

  " Open tab to left of current.
  " http://stackoverflow.com/a/13275945
  command! -nargs=* -bar TabnewL :execute (tabpagenr()-1).'tabnew '.<q-args>

  " Open new tabs
  map <C-t> :tabnew<CR>
  map <C-w> :TabnewL<CR>

" Text Navigation And Movements: =======================================

  " Makes navigation work in wrapped text.
  " TODO: Get out of this habbit
  map j gj
  map k gk
  map ^ g^
  map $ g$

  " The default "CamelCaseMotion" keys
  " Must specify because of other overrides.
  map ,w <Plug>CamelCaseMotion_w
  map ,b <Plug>CamelCaseMotion_b
  map ,e <Plug>CamelCaseMotion_e

  " IntelliJ has pseudo-CamelCaseMotion keys (match them)
  map [w <Plug>CamelCaseMotion_w
  map [b <Plug>CamelCaseMotion_b
  map [e <Plug>CamelCaseMotion_e

" Modalities: ==========================================================

  " Switch between showing line numbers
  nmap <C-L> :set number!<CR>

" Status Line: =========================================================
  " To conserve vertical space (since I often use small form-factor
  " netbooks), I've made my status line modal. It only shows up in
  " visual mode.

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
  " I freaking hate clipboard buffers. This should be a first class
  " thing in the OS (at a lower level than the graphical shell) to
  " read/writeable by any process. But I digress...

  " TODO: Make this work inside my work Mac and inside tmux.

  " HIGHLY OPINIONATED CHANGE, YOU PROBABLY WON'T LIKE IT.
  " I hate that vim pastes at the cursor. I always want a newline.
  " TODO: Trying not to use anymore as of 2014-09-08. I miss it so bad.
  "nmap p :pu<CR> " Sigh, having to conform to everyone else's reality...

  " Copy/paste from system clipboard
  " Requires `xclip` binary.
  vmap <C-c> y: call system("xclip -i -selection clipboard",
      \ getreg("\""))<CR>
  nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
  imap <C-v> <esc>:call setreg("\"",
      \ system("xclip -o -selection clipboard"))<CR>pi

" Old Ungrouped Stuff: =================================================

  " Remove current search term/state
  " TODO: Make sure I didn't override a function
  nmap t :let @/ = ""<CR><CR>

  " Toggle spelling
  map <F5> :set spell! spelllang=en_us<CR>

  " Switch colorschemes
  " TODO: Vundle package broken?
  "map <F9> :call NextColor(-1)<CR>
  "map <F10> :call NextColor(1)<CR>

  " Open NERDtree plugin
  "map <C-f> :NERDTree<CR>
  "map <Leader>n :<CR>

  " Change the Fold Text
  " http://stackoverflow.com/a/5984138
  function! MyFoldText()
    let numLines = v:foldend - v:foldstart + 1
    let linetext = substitute(getline(v:foldstart),"^ *","",1)
    let txt = '+ ' . numLines . ' lines '
    return txt
  endfunction

  "set foldtext=MyFoldText()

