"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
	" colorschemes
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'sickill/vim-monokai'
  Plug 'cormacrelf/vim-colors-github'
  Plug 'tomasiser/vim-code-dark'
  " Vim airline
  Plug 'vim-airline/vim-airline'
	" typescript support
	Plug 'leafgarland/typescript-vim'
	" javascript (and jsx) support
	Plug 'pangloss/vim-javascript'
	Plug 'mxw/vim-jsx'
	" Tsx file syntax support
	Plug 'ianks/vim-tsx'
	" Autocompletation VSCode like
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Editor config
	Plug 'editorconfig/editorconfig-vim'
	" Git signs
	Plug 'mhinz/vim-signify'
	" Fuzzy Ctrl+P (Fuzzy Finder)
	Plug 'ctrlpvim/ctrlp.vim'
	" Vim Wakatime
	Plug 'wakatime/vim-wakatime'
	" NerdTree
	Plug 'scrooloose/nerdtree'
  " Ctrlsf Search
  Plug 'dyng/ctrlsf.vim'
  " Multiple cursors
  Plug 'terryma/vim-multiple-cursors'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPLEADER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast savingme = 1
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>

" Clear search hightlight
nmap <leader>c :nohl<cr>

" Toggle NERDtree
map <C-f> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Ctrl+X, Ctrl+C and Ctrl+V
" Only works after installing vim-gnome package on Ubuntu 10.04
vnoremap <leader>x "+d
vnoremap <leader>c "+y
nnoremap <leader>v "+p
nnoremap <leader>V "+P

" Fuzzy Finder
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SIGNIFY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEME
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
colorscheme codedark
" use the dark theme
" set background=dark
" let g:github_colors_block_diffmark = 0
"
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
 if (has('nvim'))
   let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
 endif
 let g:rehash256 = 1

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
 if (has('termguicolors'))
  set termguicolors
endif

" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
"let g:material_theme_style = 'darker'

" Vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'codedark'
set laststatus=2
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM COC 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-json', 'coc-tsserver', 'coc-emmet', 'coc-tslint', 'coc-eslint', 'coc-prettier', 'coc-highlight', 'coc-vetur']

" Allways show signcolumn
set signcolumn=yes

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Multiple selections with Ctrl D
" nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" use <tab> for trigger completion and navigate to the next complete item
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Better display for messages
set cmdheight=2

" Remap keys for gotos
" Ctrl + O = back to prev buffer
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Prettier command
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Prettier format on save
nnoremap gp :Prettier<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITOR CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Back to previous with backspace deletion
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Set utf-8 as standard encoding and en_US as the standard language
set encoding=utf8

" Split order
set splitright
set splitbelow

" Set bash as default shell
set shell=/bin/bash
syntax on
" Vim history
set history=300

" Set to auto read when a file is changed from the outside
set autoread

" Set mousescroll and selection
set mouse=a

" Enable filetype plugins
filetype plugin on
filetype indent on

" Let gitgutter already torned on
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set numbers
set number
set relativenumber

" Ignore case when searching
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Highlight the current cursor line
set cursorline


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT, TAB AND INDENT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Remember info about open buffers on close
set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE MAPPING, BACKUPS and UNDO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes support
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *spec.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
au BufNewFile,BufRead *spec.tsx setlocal filetype=typescript.tsx
au BufReadPost,BufNewFile,BufRead *.spec.js set filetype=jasmine.javascript syntax=jasmine

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL P (Fuzzy Finder)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide files into .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Show dotfiles
let g:ctrlp_show_hidden = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 100
map <leader>b :CtrlPBuffer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL P (Fuzzy Finder)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Opens search prompt
nmap     <C-F>f <Plug>CtrlSFPrompt
" Opens search prompt with visual selected word
vmap     <C-F>f <Plug>CtrlSFVwordPath
" Exec search with visual selected word
vmap     <C-F>F <Plug>CtrlSFVwordExec
" Opens search prompt with the current cursor word
nmap     <C-F>n <Plug>CtrlSFCwordPath
"nmap     <C-F>p <Plug>CtrlSFPwordPath
" Open search result panel
nnoremap <C-F>o :CtrlSFOpen<CR>
" Toggle search prompt
nnoremap <C-F>t :CtrlSFToggle<CR>
"inoremap <C-F>t <Esc>:CtrlSFToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL MODE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Identations
vnoremap << <gv
vnoremap >> >gv
vnoremap = =gv

" Copy to clipboard
noremap <leader>y "*y
noremap <leader>p "*p

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,$bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabn<cr>
map <leader>tp :tabp<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
nmap <leader>T :tabnew<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HELPER FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
