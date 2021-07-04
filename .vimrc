set nocompatible
filetype off

" Disbale Netrw
let loaded_netrwPlugin = 0

" command! MakeTags !ctags -R . --exclude=.git --exclude=log *

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'                    " Navigator
Plugin 'neoclide/coc.nvim'                     " Conquer of completion
Plugin 'sheerun/vim-polyglot'                  " Collection of syntax plugins
Plugin 'dense-analysis/ale'
Plugin 'junegunn/fzf.vim'
" Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'arcticicestudio/nord-vim.git'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'ludovicchabant/vim-gutentags.git'
Plugin 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
" Plugin 'tpope/vim-sensible'
" Plugin 'rking/ag.vim'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'qpkorr/vim-bufkill'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-unimpaired'               " For Fugitive's Clog
" Plugin 'jiangmiao/auto-pairs'
call vundle#end()

" Theme
set termguicolors
" colorscheme dracula
colorscheme nord
set laststatus=2
" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" Change leader to a comma
let mapleader=","

filetype plugin indent on
syntax on

" ############################################
" General configuration
" ############################################
set hidden                          " Enables hidden buffers
set path+=**                        " Recursive find
set wildmenu                        " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:full              " List and cycle through matches
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
set clipboard=unnamed               " Share clipboard with OS
set ttyfast                         " Send more characters at a given time.
set synmaxcol=400                   " Text after this col is not highlighted
set lazyredraw                      " Screen not redrawn while executing  macros
" set splitbelow                      " New window goes below
" set splitright                      " New windows goes right
set autoread                        " Auto refresh changed files
set cursorline                      " Highlight current line
set autoindent                      " Keep indentation from last line when new line.
set expandtab                       " Expand tabs to spaces
" set modelines=0                     " Allow you to set variables specific to a file
set shiftwidth=2                    " The # of spaces for indenting.
" set ttyscroll=3
set tabstop=2                       " Tab key results in 2 spaces
set nowrap                          " turn off line wrapping
set number                          " Show line numbers
set relativenumber
set hlsearch                        " Highlight search results
set ignorecase                      " Ignore case of searches.
set smartcase                       " Ignore 'ignorecase' if search patter contains uppercase characters.
set smarttab                        " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set incsearch                       " Highlight dynamically as pattern is typed.
set mouse=a                         " Enable moouse in all in all modes.
set ttymouse=xterm2                 " Fixes mouse issue when running in Tmux
set pastetoggle=<leader>v           " set paste toggle
set backspace=indent,eol,start
set re=0                            " prevent redraw exceeded issue with Typescript

" ############################################
" Automatic formatting
" ############################################

augroup formattingcommands
  autocmd!
  autocmd BufWritePre *.rb   :%s/\s\+$//e
  autocmd BufWritePre *.js   :%s/\s\+$//e
  autocmd BufWritePre *.ts   :%s/\s\+$//e
  autocmd BufWritePre *.tsx  :%s/\s\+$//e
  au BufNewFile * set noeol
augroup END

" ############################################
" Key mappings
" ############################################
"
" Quick ESC
imap jj <ESC>
imap kk <ESC>

" Edit vimr configuration file
nnoremap <leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <leader>vr :source $MYVIMRC<CR>

" clear highlighted search
noremap <leader>/ :set hlsearch! hlsearch?<cr>

noremap <enter> :Goyo<cr>

" Quicker window switching
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

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

" List buffers
nnoremap <leader><Tab> :buffer<Space><Tab>

" Tab between splits
noremap <tab> <c-w><c-w>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Resize buffers
nmap h 5<C-W><
nmap l 5<C-W>>
nmap k 5<C-W>-
nmap j 5<C-W>+

" Change splits from vert to horizontal and viceversa
map <leader>th <C-w>t<C-w>H
map <leader>tk <C-w>t<C-w>K

" Open terminal
map <leader>ttl :vert term<cr>
map <leader>ttk :term<cr>

" Move lines up and down
" ∆ Option+J
" ˚ Option+K
nnoremap ∆ :m .+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
nnoremap ˚ :m .-2<CR>==
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ˚ :m '<-2<CR>gv=gv


" ############################################
" Plugins configuration
" ############################################

" Gutentags
" set tags=./.tags,.tags;
set tags=.tags;
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_generate_on_new = 1
let g:gutentags_file_list_command = {
  \ 'markers': {
     \ 'wp-admin': 'rg --files',
     \ '.git': 'git ls-files',
  \ },
\ }
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>



" Commenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" Goyo
let g:goyo_width = 160

" FZF and RipGrep search
" https://github.com/junegunn/fzf.vim
" https://sidneyliebrand.medium.com/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
" https://github.com/junegunn/fzf.vim/issues/714
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" " [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6 } }
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" Lightline
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = { 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified'] ]
        \ },
        \ 'component_function': {
          \   'gitbranch': 'fugitive#head',
          \   'cocstatus': 'coc#status',
          \   'currentfunction': 'CocCurrentFunction'
          \ },
          \ }

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=0

" Fugitive
nmap <silent> <leader>gs :Git<cr>
nmap <silent> <leader>gb :Gblame<cr>
nmap <silent> <leader>gl :Gclog<cr>
nmap <silent> <leader>gc :Git commit<cr>

