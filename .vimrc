set nocompatible
filetype off

"Runtime path for Vundle
if has('win32') || ('win64')
  set rtp+=~/vimfiles/bundle/Vundle.vim/
  let path='~/vimfiles/bundle'
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif

call vundle#begin()

" This is the vundle package itself
Plugin 'gmarik/vundle'

" Airline plugin
if has('unix')
  Plugin 'bling/vim-airline'
endif

" Git plugin
Plugin 'tpope/vim-fugitive'

" NERDCommenter
Plugin 'scrooloose/nerdcommenter'

" Easy Motion
Plugin 'Lokaltog/vim-easymotion'

" Vim-gutter
Plugin 'airblade/vim-gitgutter'

" Luna colorscheme
Plugin 'Pychimp/vim-luna'

" AutoComplPop
Plugin 'vim-scripts/AutoComplPop'

" Surround
Plugin 'tpope/vim-surround'

" Enhanced CPP Highlights
Plugin 'octol/vim-cpp-enhanced-highlight'

" Relative numbering only in normal mode
Plugin 'myusuf3/numbers.vim'

" Graphical undo
Plugin 'sjl/gundo.vim'

" Gentle auto-pairing
Plugin 'vim-scripts/auto-pairs-gentle'

" Vim addons
Plugin 'marcweber/vim-addon-mw-utils'

" Snipmate
Plugin 'garbas/vim-snipmate'

" Needed for snipmate
Plugin 'tomtom/tlib_vim'

" Vim auto stop with swap messages
Plugin 'autoswap.vim'

" Colors
Plugin 'tomasr/molokai'

call vundle#end()
filetype plugin indent on

" For airline
if has('unix')
  set guifont=Liberation\ Mono\ for\ Powerline\ 10
  set laststatus=2
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = '>'
  let g:airline#extensions#tabline#left_alt_sep = '>'
endif

" NERDcommenter mapping
nmap // <leader>ci
nmap .. <leader><leader>w
nmap ,, <leader><leader>b

syntax on
syntax enable

set backspace=indent,eol,start
set background=dark
set shiftwidth=4
set shiftround
set tabstop=4
set smarttab
set wildmenu

set showmatch
set showcmd     "To show partial command in status bar
set nu        "For current line number
set rnu       "Relative numbering for the rest of the lines
set sidescroll=1

set ignorecase
set smartcase     "CSen only when capitals used.
set hlsearch

set autoindent
set copyindent
set smartindent
set cindent

set history=1000
set undolevels=1000
set scrolloff=6

set guioptions-=m
set guioptions-=T

cmap w!! w !sudo tee % >/dev/null

colors pablo 

set pastetoggle=<F2>  "Toggles paste mode

:autocmd Filetype make set noexpandtab

if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" |endif
endif

set t_Co=256

if has('unix')
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	"if (gui)
		" unicode symbols
		"let g:airline_left_sep = '»'
		"let g:airline_left_sep = '▶'
		"let g:airline_right_sep = '«'
		"let g:airline_right_sep = '◀'
		"let g:airline_symbols.linenr = '␊'
		"let g:airline_symbols.linenr = '␤'
		"let g:airline_symbols.linenr = '¶'
		"let g:airline_symbols.branch = '⎇'
		"let g:airline_symbols.paste = 'ρ'
		"let g:airline_symbols.paste = 'Þ'
		"let g:airline_symbols.paste = '∥'
		"let g:airline_symbols.whitespace = 'Ξ'
	"endif
endif
