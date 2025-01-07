" Ensure vim shells out to zsh
set shell=zsh
" Make Vim more useful
set nocompatible
" Enhance command-line completion
set wildmenu
set wildmode=longest:list,full

" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8

" Turn off backups
set nobackup
set nowritebackup

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
" Make tabs as wide as two spaces
" Make tabs two spaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set shiftround
set smarttab
set complete-=i
set showmatch
set nrformats-=octal

" Don't prompt to save when switching buffers, only when exiting vim
set hidden
set confirm

set ttimeout
set ttimeoutlen=50
set autoread
set fileformats+=mac

" Use the system clipboard
set clipboard=unnamed

" Show “invisible” characters
set lcs=tab:→⋅,trail:·,extends:»,precedes:«
" Show a visual max line length indicator
set colorcolumn=80
set textwidth=80
set list
" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch
" Live substitution previews
set inccommand=nosplit
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
" Shorten most messages and don't pass them to ins menu
set shortmess=atIc
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
set cmdheight=2

" Improve delays and performance UX
set updatetime=300

" Enable line numbers; relative by default
set number
set relativenumber

" Highlight current line
set cursorline
" Always keep some space before and after cursor
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

set signcolumn=yes
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Split in expected directions
set splitright
set splitbelow

" Be smarter about mouse support in tmux
set mouse+=a
if !has('nvim')
  if &term =~ '^screen'
    set ttymouse=xterm2
  endif
endif

" up/down work as expected with word wrapping on
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Exit insert mode with jk
:inoremap jk <esc>
:inoremap kj <esc>

" Make nvim mode navigation more handy
if has('nvim')
  tnoremap <leader><Esc> <C-\><C-n>
end

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif


" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype plugin indent on
  " Use tabs in go
  autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

  " Syntax highlight sync more often in JS/TS projects
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

  " Close completion window after insert or complete
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  " Use relative absolute numbers in insert mode, relative otherwise
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
endif

" Pretty colors
colorscheme base16-unikitty

" Enable syntax highlighting
syntax enable
