" NeoBundle
"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/home/saksham/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/saksham/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'scrooloose/syntastic'
call neobundle#config('syntastic', {
	\ 'lazy' : 1,
	\ 'autoload' : {
	\   'insert' : 1,
	\ }})

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'ctrlpvim/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------



" Plugins
" =====================================
" =====================================

call plug#begin()

" Functionality
Plug 'vim-scripts/AutoComplPop'
Plug 'scrooloose/nerdtree'
Plug 'edsono/vim-matchit'
Plug 'ervandew/supertab'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/auto-pairs-gentle'
Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-sleuth'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'autoswap.vim'
Plug 'KabbAmine/zeavim.vim'

" Shortcuts
Plug 'scrooloose/nerdcommenter'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/closetag.vim'

" Appearance
Plug 'bling/vim-airline'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'myusuf3/numbers.vim'

" Colorschemes
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'Pychimp/vim-luna'

" Language-specific
Plug 'derekwyatt/vim-scala'
Plug '2072/vim-syntax-for-PHP'
Plug 'raichoo/haskell-vim'
Plug 'fatih/vim-go'
Plug 'dart-lang/dart-vim-plugin'
Plug 'digitaltoad/vim-jade'
Plug 'lervag/vimtex'
Plug 'rgrinberg/vim-ocaml'
Plug 'kchmck/vim-coffee-script'

Plug 'eagletmt/neco-ghc'            " For haskell completions
Plug 'eagletmt/ghcmod-vim'

call plug#end()


" Custom Mappings
" =====================================
" =====================================

" Save with root priviledges
cmap w!! w !sudo tee % >/dev/null

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" New space mappings
nnoremap <Space>w :w<CR>
nnoremap <Space>q :wq<CR>
vmap <Space>y "+yy
vmap <Space>d "+dd
nmap <Space>y "+yy
nmap <Space>d "+dd
nmap <Space>p "+p
nmap <Space>P "+P
vmap <Space>p "+p
vmap <Space>P "+P

" Allows going down in the wrapped portion of a line
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Make new windows with <ctrl>+w + v , <ctrl>+w + s and close with <ctrl>+w+q
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h

" Allows you to do a single normal mode action and come back to insert mode
"inoremap \\ <C-o>

" Compile LaTeX and view in zathura
"nmap <F5> :w !pdflatex %<return> :!zathura %:r.pdf&<return><return>
nmap <F5> ;w !pdflatex %<return>

nmap <Space> i_<Esc>r

" Specially for PHP and HTML dev
map <F7> :set ft=html<return>
map <F8> :set ft=phtml<return>

" Custom Settings
" =====================================
" =====================================

syntax on
filetype plugin indent on
syntax enable
set nowrap

set undofile
set undodir=~/.vim/undodir
set undolevels=1000

set foldmethod=indent   " Enable code folding with z,a
set foldlevel=99

set backspace=indent,eol,start
set background=dark
set shiftwidth=2
set shiftround
set tabstop=2
set smarttab
set expandtab
set wildmenu

set showmatch
set showcmd     "To show partial command in status bar
set nu        "For current line number
set rnu       "Relative numbering for the rest of the lines
set sidescroll=1

set ignorecase
set smartcase     "CSen only when capitals used.
set incsearch   "Starts showing results as you type
set hlsearch

set autoindent
set copyindent
set smartindent
set cindent

set history=1000
set scrolloff=6
set autoread    "Reloads file on change
set lazyredraw    " redraw only when we need to

set guioptions-=m
set guioptions-=T

set pastetoggle=<F2>  "Toggles paste mode

:autocmd Filetype make set noexpandtab

" To restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

" To show diff with saved version of the file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" Appearance
" =====================================
" =====================================

colors jellybeans
set t_Co=256
set gfn=monofur\ for\ Powerline\ Regular\ 14


" Plugin mappings
" =====================================
" =====================================

" For LaTeX-Suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" For camelcasemotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" For haskell
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_indent_if = 3

" NERDcommenter mapping
nmap // <leader>ci

" EasyMotion
nmap .. <leader><leader>w
nmap ,, <leader><leader>b

" NERDTree
nmap <c-n> :NERDTreeToggle<return>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  "To autoclose if only nerd left

" For airline
if has('unix')
  set guifont=Liberation\ Mono\ for\ Powerline\ 14
  set laststatus=2
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
endif

if has('unix')
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
endif

" For syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" For neco-ghc
"
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


" Misc
" =========

set wrap

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" The following content taken from Harsh Sharma's vimrc

" To toggle line numbering
noremap <F4> :set invnu invrnu<CR>

" Switch between different tab widths
nnoremap <Leader>2 :set sw=2 <Bar> set sts=2<CR>
nnoremap <Leader>4 :set sw=4 <Bar> set sts=4<CR>


" capitalize the word preceding the cursor in insert mode
imap <C-C> <Esc>gUiw`]a


" map : to ; and vice-versa
" so you don't have to hold down shift to get into command mode
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" repeat last defined macro, Bonus: no Ex mode
nnoremap Q @@


" indent guides
nnoremap <Leader>i :IndentGuidesToggle<CR>

set title

map <F8> :noremap j 3j <CR> :noremap k 3k <CR>
map <S-F8> :noremap j j <CR> :noremap k k <CR>


" Notes
" ===============
"
" For syntastic
" ===
"
" C/C++   ==> Install gcc
" CSS     ==> sudo npm install -g csslint
" Dart    ==> dartanalyzer (comes with dart)
" JS/HTML ==> sudo npm install -g jshint
" JSON    ==> sudo npm install -g jsonlint
"
" For haskell
" ===
" Install ghc-mod
