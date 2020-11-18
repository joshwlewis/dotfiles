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
  nmap <silent> <leader>e :FZF<CR>
  nmap <silent> <leader>o :Buffers<CR>
  nmap <silent> <leader>u :Rg<CR>
Plug 'dense-analysis/ale'
  let g:ale_fixers = { 'javascript': ['prettier'], 'go': ['goimports'] }
  let g:ale_linters = { 'go': ['gobuild', 'golint', 'golangci-lint'] }
  let g:ale_go_golangci_lint_package=1
  let g:ale_go_golangci_lint_options='--fast'
  nmap <silent> <leader>lf :ALEFix<CR>
  nmap <silent> <leader>ll :ALELint<CR>
Plug 'scrooloose/nerdtree'
  nmap <silent> <leader>t :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1
  let NERDTreeIgnore = ['\.DS_Store','\.git','\.svn','\.sass-cache$']
Plug 'tmhedberg/matchit'
  runtime! macros/matchit.vim
Plug 'janko-m/vim-test'
  let test#strategy = "neovim"
  nmap <silent> <leader>tn :TestNearest<CR>
  nmap <silent> <leader>tf :TestFile<CR>
  nmap <silent> <leader>ts :TestSuite<CR>
  nmap <silent> <leader>tl :TestLast<CR>
  nmap <silent> <leader>tv :TestVisit<CR>
Plug 'JulesWang/css.vim',                { 'for': 'css' }
Plug 'honza/dockerfile.vim',             { 'for': 'dockerfile' }
Plug 'elixir-lang/vim-elixir',           { 'for': 'elixir' }
Plug 'fatih/vim-go',                     { 'for': 'go' }
  let g:go_fmt_autosave = 0
Plug 'tpope/vim-haml',                   { 'for': ['haml', 'sass', 'scss' ] }
Plug 'othree/html5.vim',                 { 'for': 'html' }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars', 'html.mustache'] }
Plug 'pangloss/vim-javascript',          { 'for': ['javascript', 'jsx'] }
Plug 'mxw/vim-jsx',          { 'for': ['javascript', 'jsx'] }
Plug 'elzr/vim-json',                    { 'for': 'json' }
  let g:vim_json_syntax_conceal = 0
Plug 'groenewege/vim-less',              { 'for': 'less' }
Plug 'tpope/vim-markdown',               { 'for': 'markdown' }
Plug 'keith/rspec.vim',                  { 'for': 'rspec' }
Plug 'vim-ruby/vim-ruby',                { 'for': 'ruby' }
Plug 'rust-lang/rust.vim',               { 'for': 'rust' }
  let g:rustfmt_autosave = 1
Plug 'cespare/vim-toml',                 { 'for': 'toml' }
Plug 'keith/tmux.vim',                   { 'for': 'tmux' }
Plug 'leafgarland/typescript-vim'


call plug#end()

call deoplete#custom#option('omni_patterns', {
\  'go': '[^. *\t]\.\w*',
\ })


" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype plugin indent on
  " Use tabs in go
  autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  " Close completion window after insert or complete
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif

" Pretty colors
colorscheme base16-unikitty

" Enable syntax highlighting
syntax enable

