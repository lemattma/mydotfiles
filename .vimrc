set nocompatible
filetype off

" Disbale Netrw
let loaded_netrwPlugin = 0

command! MakeTags !ctags -R . --exclude=.git --exclude=log *

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-sensible'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'qpkorr/vim-bufkill'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'               " For Fugitive's Clog
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
call vundle#end()

set background=dark
color solarized

" Change leader to a comma
let mapleader=","

filetype plugin indent on
syntax on

" ############################################
" General configuration
" ############################################
set path+=**                                                                " Recursive find
set wildmenu                                                                " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:longest                                                   " Complete only until point of ambiguity.
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
set clipboard=unnamed                                                       " Share clipboard with OS
set ttyfast                                                                 " Send more characters at a given time.
set synmaxcol=200
set lazyredraw
set splitbelow                                                              " New window goes below
set splitright                                                              " New windows goes right
set autoread                                                                " Auto refresh changed files
" set cursorline                                                            " Highlight current line SLOW
set autoindent                                                              " Copy indent from last line when starting new line.
set expandtab                                                               " Expand tabs to spaces
set modelines=0
set shiftwidth=2                                                            " The # of spaces for indenting.
set synmaxcol=1000
set ttyscroll=10
set tabstop=2                                                               " Tab key results in 2 spaces
set nowrap                                                                  " turn off line wrapping
set list                                                                    " toggle invisible characters
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set re=1                                                                    " Fix syntax regex too slow in Ruby files
set number                                                                  " Show line numbers
set relativenumber                                                          " Use relative line numbers. Current line is still in status bar.
set hlsearch                                                                " Highlight search results
set ignorecase                                                              " Ignore case of searches.
set smartcase                                                               " Ignore 'ignorecase' if search patter contains uppercase characters.
set smarttab                                                                " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set incsearch                                                               " Highlight dynamically as pattern is typed.
set mouse=a                                                                 " Enable moouse in all in all modes.
set pastetoggle=<leader>v                                                   " set paste toggle



" ############################################
" Powerline config
" ############################################

set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8 nobomb " BOM often causes trouble
set termencoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
if has("gui_running")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set guifont=Inconsolata\ for\ Powerline:h15
  endif
endif



" ############################################
" Automatic formatting
" ############################################

augroup formattingcommands
  autocmd!
  autocmd BufWritePre *.rb   :%s/\s\+$//e
  autocmd BufWritePre *.go   :%s/\s\+$//e
  autocmd BufWritePre *.haml :%s/\s\+$//e
  autocmd BufWritePre *.html :%s/\s\+$//e
  autocmd BufWritePre *.scss :%s/\s\+$//e
  autocmd BufWritePre *.slim :%s/\s\+$//e
  au BufNewFile * set noeol
augroup END



" ############################################
" Key mappings
" ############################################
"
" Quick ESC
imap jj <ESC>

" clear highlighted search
noremap <space> :set hlsearch! hlsearch?<cr>

" Quicker window switching
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" shortcuts to save
nmap <leader>,                    :w<cr>
noremap <silent> <C-S>       :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" format the entire file
nmap <leader>fef ggVG=


" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Resize buffers
if bufwinnr(1)
  nmap ˙ 3<C-W><
  nmap ¬ 3<C-W>>
  nmap ∆ 3<C-W>-
  nmap ˚ 3<C-W>+
endif



" ############################################
" Plugins configuration
" ############################################

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=0

" CtrlP
nnoremap <silent>t :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 0
let g:ctrlp_max_files = 15000
let g:ctrlp_max_depth = 10
let g:ctrlp_show_hidden = 1
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$\|db\/migrate$\|node_modules$\|build$',
      \ 'file': '\.exe$\|\.so$\|\.dat$'
      \ }

" ag search
nnoremap \ :Ag<SPACE>-ri<SPACE>

" Rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = "!bundle exec spring rspec --no-profile {spec}"

" Fugitive
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

