set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" This is the vundle package itself
Plugin 'gmarik/vundle'

" Airline plugin
Plugin 'bling/vim-airline'

" Easy Motion
Plugin 'Lokaltog/vim-easymotion'

" Vim-gutter
Plugin 'airblade/vim-gitgutter'

" Luna colorscheme
Plugin 'Pychimp/vim-luna'

" NERDCommenter
Plugin 'scrooloose/nerdcommenter'

" TMuxLine
Plugin 'edkolev/tmuxline.vim'

" YouCompleteMe
" Plugin 'Valloric/YouCompleteMe'

" AutoComplPop
Plugin 'vim-scripts/AutoComplPop'

" Now turning filetype back on
filetype plugin indent on

au BufRead,BufNewFile *.ino,*.pde set filetype=c++

set guifont=Liberation\ Mono\ for\ Powerline\ 10

" For airline
set laststatus=2
let g:airline#extensions#labline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDcommenter mapping
nmap // <leader>ci
nmap .. <leader><leader>w
nmap ,, <leader><leader>b

syntax on
syntax enable
set background=dark
set shiftwidth=4
set shiftround
set tabstop=4
set smarttab

set showmatch
set showcmd	"Show partial command in status bar
set nu		"For current line number
set rnu 	"Line numbers are relative
set sidescroll=1

set ignorecase
set smartcase	"Case sensitive only when capitals used
set hlsearch

set autoindent
set copyindent
set smartindent
set cindent

set history=1000
set undolevels=1000
set scrolloff=6

set pastetoggle=<F2>	"Toggles paste mode

cmap w!! w !sudo tee % >/dev/null

" Color scheme
colors luna

:autocmd Filetype make set noexpandtab

if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" |endif
endif

set t_Co=256

 if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
