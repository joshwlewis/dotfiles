" Ensure vim shells out to bash
set shell=/bin/bash

colorscheme base16-ateliercave

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
" Make tabs two spaces
set expandtab
set shiftwidth=2
set autoindent
set shiftround
set smarttab
set complete-=i
set showmatch
set nrformats-=octal
set ttimeout
set ttimeoutlen=50
set autoread
set fileformats+=mac

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,extends:»,precedes:«
" Show a visual max line length indicator
set colorcolumn=80
set textwidth=80
set list
" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
set t_Co=256
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Split in expected directions
set splitright
set splitbelow

filetype plugin indent on

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

" Be smarter about mouse support in tmux
set mouse+=a
if &term =~ '^screen'
  set ttymouse=xterm2
endif

" Strip all whitespace
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" up/down work as expected with word wrapping on
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" use standard regular expressions instead of out of the box vim
nnoremap / /\v
xnoremap / /\v

execute pathogen#infect()

" Plugin: vim-markdown
let g:vim_markdown_folding_disabled=1

" Plugin: ctrl-p
if executable('ag')
  " Use the silver searcher when available
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
else
  " Otherwise, we need our own custom ignores
  let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](node_modules|bower_components|coverage|tmp|\.git|\.hg|\.svn)$',
    \ 'file': '\v(\.exe|\.zip|\.DS_Store|\.swp|\.ico)$',
    \ }
endif

" Plugin: NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.DS_Store','\.git','\.svn','\.sass-cache$']

" Plugin: matchit
runtime! macros/matchit.vim

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
