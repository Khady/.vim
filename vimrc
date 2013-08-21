set nocompatible               " Be iMproved
set t_Co=256

" ---------------------------------------------------------------------------
" NeoBundle settings
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Command-T'
NeoBundle 'a.vim'
NeoBundle 'vim-easy-align'
NeoBundle 'arpeggio'
NeoBundle 'Gundo'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'rainbow_parentheses.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'jpalardy/vim-slime'

"NeoBundle 'sensible.vim' " default settings

filetype plugin indent on     " Required!

NeoBundleCheck

" ---------------------------------------------------------------------------
" statusline stuff
set laststatus=2 " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs

set ignorecase smartcase

filetype plugin on " enable plugins
set tags+=./tags

" ---------------------------------------------------------------------------
" first the disabled features due to security concerns
set modelines=0         " no modelines [http://www.guninski.com/vim1.html]
"let g:secure_modelines_verbose=1 " securemodelines vimscript

" ---------------------------------------------------------------------------
" configure other scripts

let c_no_curly_error = 1

" ---------------------------------------------------------------------------
" operational settings
set nocompatible                " vim defaults, not vi!
syntax on                       " syntax on
set hidden                      " allow editing multiple unsaved buffers
set more                        " the 'more' prompt
filetype on                     " automatic file type detection
set autoread                    " watch for file changes by other programs
"set visualbell                  " visual beep
set vb t_vb=
set visualbell t_vb=

":set patchmode=~                " only produce *~ if not there
set noautowrite                 " don't automatically write on :next, etc
let maplocalleader=','          " all my macros start with ,
set wildmenu                    " : menu has tab completion, etc
" Highlight cursor line.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorline
  au WinLeave * setlocal nocursorcolumn
augroup END
"set cursorline
"set cursorcolumn
set scrolloff=5                 " keep at least 5 lines above/below cursor
set sidescrolloff=5             " keep at least 5 columns left/right of cursor
set history=300                 " remember the last 300 commands
set showcmd
set number

set expandtab
set shiftwidth=2
set softtabstop=2

" ---------------------------------------------------------------------------
" meta
map <LocalLeader>cs :source ~/.vimrc<cr>        " quickly source this file

inoremap <Tab> <tab>
vnoremap <Tab> =

" ---------------------------------------------------------------------------
" window spacing
" set cmdheight=2                 " make command line two lines high
set ruler                       " show the line number on bar
set lazyredraw                  " don't redraw when running macros
"set number                      " show line number on each line
"set winheight=999               " maximize split windows
"set winminheight=0              " completely hide other windws

nmap s :set relativenumber<CR>
nmap S :set number<CR>
map <c-d> :shell<CR>
map <LocalLeader>w+ 100<C-w>+  " grow by 100
map <LocalLeader>w- 100<C-w>-  " shrink by 100

" ---------------------------------------------------------------------------
" mouse settings
set mouse-=a                     " mouse support in all modes
set mousehide                   " hide the mouse when typing text

" ,p and shift-insert will paste the X buffer, even on the command line
nmap  s i<S-MiddleMouse><ESC>
imap <S-Insert> <S-MiddleMouse>
cmap <S-Insert> <S-MiddleMouse>

" this makes the mouse paste a block of text without formatting it
" (good for code)
map <MouseMiddle> <esc>"*p

" ---------------------------------------------------------------------------
" global editing settings
set autoindent smartindent cindent     " turn on auto/smart indenting
set expandtab                 " use spaces, not tabs
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=2                 " tabstops of 2
set shiftwidth=2                " indents of 2
set backspace=eol,start,indent  " allow backspacing over indent, eol, & start
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set cino =>4^-2e2{2n-2
set textwidth=80


" ---------------------------------------------------------------------------
" searching...
set hlsearch                   " enable search highlight globally
set incsearch                  " show matches as soon as possible
set showmatch                  " show matching brackets when typing
" disable last one highlight
map <LocalLeader>nh :nohlsearch<cr>

set diffopt=filler,iwhite       " ignore all whitespace and sync

" ---------------------------------------------------------------------------
if has('autocmd')
  filetype plugin indent on
  syntax on

  " jump to last line edited in a given file (based on .viminfo)
  autocmd BufReadPost *
        \ if line("'\"") > 0|
        \       if line("'\"") <= line("$")|
        \               exe("norm '\"")|
        \       else|
        \               exe "norm $"|
        \       endif|
        \ endif

  " improve legibility
  au BufRead quickfix setlocal nobuflisted wrap number

  au BufRead,BufNewFile *.eliom setfiletype ocaml
  " configure various extenssions
  let git_diff_spawn_mode=2
endif


" ---------------------------------------------------------------------------
" spelling...
if v:version >= 700
  let b:lastspelllang='en'
  function! ToggleSpell()
    if &spell == 1
      let b:lastspelllang=&spelllang
      setlocal spell!
    elseif b:lastspelllang
      setlocal spell spelllang=b:lastspelllang
    else
      setlocal spell spelllang=en
    endif
  endfunction

  nmap <LocalLeader>ss :call ToggleSpell()<CR>

  setlocal spell spelllang=en
  setlocal nospell
endif


" ---------------------------------------------------------------------------
" some useful mappings

" disable yankring
let loaded_yankring = 22

" Y yanks from cursor to $
map Y y$
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>
" change directory to that of current file
nmap <LocalLeader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <LocalLeader>lcd :lcd%:p:h<cr>
" correct type-o's on exit
nmap q: :q

" word swapping
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>
" char swapping
nmap <silent> gc xph

" save and build
nmap <LocalLeader>wm  :w<cr>:make<cr>

" ---------------------------------------------------------------------------
"  buffer management, note 'set hidden' above

" Move to next buffer
map <LocalLeader>bn :bn<cr>
" Move to previous buffer
map <LocalLeader>bp :bp<cr>
" List open buffers
map <LocalLeader>bb :ls<cr>
" Close current buffer but not the window
nmap <localLeader>d :b#<bar>bd#<CR>

" ---------------------------------------------------------------------------
" dealing with merge conflicts

" find merge conflict markers
:map <LocalLeader>fc /\v^[<=>]{7}( .*\|$)<CR>


" ---------------------------------------------------------------------------

" switch current word with the next one without moving the cursor
nnoremap <silent> gn "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" switch current word with the previous one
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" switch current word with the next one
nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>


" ---------------------------------------------------------------------------
" Get documentation
function! OnlineDoc()
  let s:uname = substitute(system('uname'), "\n", "", "")
  if has("mac") || has("macunix") || has("gui_macvim") || has("gui_mac") || s:uname == "Darwin"
     let s:browser = "open"
  else
    let s:browser = "firefox"
  endif
  let s:wordUnderCursor = expand("<cword>")

  if &ft == "cpp" || &ft == "c" || &ft == "ruby" || &ft == "php" || &ft == "python" || &ft == "ocaml"
    let s:url = "http://www.google.com/search?q=".s:wordUnderCursor."+lang:".&ft
  elseif &ft == "vim"
    let s:url = "http://www.google.com/search?q=".s:wordUnderCursor
  else
    return
  endif

  let s:cmd = "silent !" . s:browser . " '" . s:url . "'"
  echo  s:cmd
  execute  s:cmd
  redraw!
endfunction

" online doc search
map <LocalLeader>k :call OnlineDoc()<CR>

" ---------------------------------------------------------------------------
" vim-airline
" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_branch_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_whitespace_symbol = 'Ξ'
let g:airline_enable_syntastic = 1
set ttimeoutlen=50
let g:airline_theme='jellybeans'

" ---------------------------------------------------------------------------
" misc, plz clean this shit

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Preserve undo between sessions
set undofile
set undodir=~/.vim/undodir

set wildignore=*.o,*~,*.pyc
set wildignore+=.git\*,.hg\*,.svn\*
" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" delete trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

autocmd VimEnter * set vb t_vb=

"let base16colorspace=256
set background=dark
colorscheme base16-tomorrow

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

set guioptions+=a " use graphic paste
set guioptions-=lrb " hide the scrollbars

" ---------------------------------------------------------------------------
" ocaml
autocmd FileType ocaml source ~/.opam/4.00.1/share/typerex/ocp-indent/ocp-indent.vim

set rtp+=~/.opam/4.00.1/share/ocamlmerlin/vimbufsync
set rtp+=~/.opam/4.00.1/share/ocamlmerlin/vim

au FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")

let g:syntastic_ocaml_checkers=['merlin']

if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

autocmd BufWritePre *.ml :call OcpIndentBuffer()

" ---------------------------------------------------------------------------
" remap keys
map <c-t> :TypeOf<CR>
vmap <c-t> :TypeOfSel<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <CR> :noh<CR><CR>:<backspace>

" Remap Ctrl-ArrowKeys to switch between split buffers
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Customization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
