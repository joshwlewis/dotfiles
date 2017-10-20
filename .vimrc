" Ensure vim shells out to zsh
set shell=/bin/zsh
" Make Vim more useful
set nocompatible
" Enhance command-line completion
set wildmenu
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8
" Change mapleader
let mapleader=","
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
" Highlight current line
set cursorline
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

if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" Set statusline color conditionally
function! SetStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=0 ctermbg=2 guifg=Black guibg=Green
  elseif a:mode == 'r'
    hi statusline ctermfg=0 ctermbg=5 guifg=Black guibg=Purple
  elseif a:mode == 'v'
    hi statusline ctermfg=0 ctermbg=9 guifg=Black guibg=DarkRed
  else
    hi statusline ctermfg=0 ctermbg=7 guifg=Black guibg=White
  endif
endfunction

" Set statusline color when changing modes
au InsertEnter * call SetStatuslineColor(v:insertmode)
au InsertLeave * call SetStatuslineColor('n')

" Set statusline to normal mode when entering vim
call SetStatuslineColor('n')

"Custom status line
set statusline=
set statusline +=\ %n\ %*            "buffer number
set statusline +=\ %{&ff}%y\ %*      "file format/type
set statusline +=\ %<%F\ %*          "full path
set statusline +=\ %m\ %*            "modified flag
set statusline +=%=%5l/%L\ %*        "current line/total lines
set statusline +=\ %4v\ %*           "virtual column number
set statusline +=\ 0x%04B\ %*        "character under cursor

" Install Plugins
call plug#begin('~/.vim/plugged')
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-git'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  map <C-p> :Files<CR>
  map <C-t> :Buffers<CR>
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
  map <C-n> :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1
  let NERDTreeIgnore = ['\.DS_Store','\.git','\.svn','\.sass-cache$']
Plug 'tmhedberg/matchit'
  runtime! macros/matchit.vim
Plug 'janko-m/vim-test'
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>
Plug 'JulesWang/css.vim',                { 'for': 'css' }
Plug 'honza/dockerfile.vim',             { 'for': 'dockerfile' }
Plug 'elixir-lang/vim-elixir',           { 'for': 'elixir' }
Plug 'fatih/vim-go',                     { 'for': 'go' }
  let g:go_fmt_command = "goimports"
Plug 'tpope/vim-haml',                   { 'for': ['haml', 'sass', 'scss' ] }
Plug 'othree/html5.vim',                 { 'for': 'html' }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars', 'html.mustache'] }
Plug 'pangloss/vim-javascript',          { 'for': 'javascript' }
Plug 'elzr/vim-json',                    { 'for': 'json' }
Plug 'groenewege/vim-less',              { 'for': 'less' }
Plug 'tpope/vim-markdown',               { 'for': 'markdown' }
Plug 'keith/rspec.vim',                  { 'for': 'rspec' }
Plug 'vim-ruby/vim-ruby',                { 'for': 'ruby' }
Plug 'rust-lang/rust.vim',               { 'for': 'rust' }
Plug 'keith/tmux.vim',                   { 'for': 'tmux' }

call plug#end()

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype plugin indent on
  " Use tabs in go
  autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
endif

" Pretty colors
colorscheme base16-unikitty

" Enable syntax highlighting
syntax enable

