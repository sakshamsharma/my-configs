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
"Plug 'raichoo/haskell-vim'
Plug 'travitch/hasksyn'
Plug 'fatih/vim-go'
Plug 'dart-lang/dart-vim-plugin'
Plug 'digitaltoad/vim-jade'
"Plug 'lervag/vimtex'

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
nmap <F5> :w !pdflatex %<return>

nmap <Space> i_<Esc>r

" Specially for PHP and HTML dev
"map <F7> :set ft=html<return>
"map <F8> :set ft=phtml<return>

map <F8> :w !subl3 %<return> :wq<return>
map <F9> :w !g++ %<return>
map <F10> :w !./a.out < input<return>
map <F11> :w !g++ -std=c++11 %<return>

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
set expandtab  " Insert space instead of tab, insert tab with Ctrl-V<Tab>
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
set scrolloff=4
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
"let g:haskell_enable_quantification = 1
"let g:haskell_enable_recursivedo = 1
"let g:haskell_enable_arrowsyntax = 1
"let g:haskell_enable_pattern_synonyms = 1
"let g:haskell_enable_typeroles = 1
"let g:haskell_enable_static_pointers = 1
"let g:haskell_indent_if = 3

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

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

set wrap
let &t_SI = "\<Esc>[6 q""]"
let &t_SR = "\<Esc>[4 q""]"
let &t_EI = "\<Esc>[2 q""]"


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
