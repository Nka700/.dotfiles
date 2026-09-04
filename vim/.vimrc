"=========================================================
" .vimrc (optimized)
"  - Vim portability first (no Neovim-only deps)
"  - Completion unified to coc.nvim (remove AutoComplPop)
"  - NERDTree is manual-only, single tree shared across tabs
"=========================================================

"---------------------------
" Leader
"---------------------------
let mapleader = ' '

set nocompatible
set nrformats=

"---------------------------
" vim-plug
"---------------------------
call plug#begin('~/.vim/plugged')

" Git / editing helpers
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" Tree (manual-only, single tree across tabs)
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'mzlogin/vim-markdown-toc'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

" Languages
Plug 'hashivim/vim-terraform'
Plug 'elzr/vim-json'
Plug 'mechatroner/rainbow_csv'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"---------------------------
" Encoding
"---------------------------
let $LANG='ja_JP.UTF-8'
set encoding=utf-8
set fileencodings=utf-8,cp932
set fileformats=unix,dos,mac

"---------------------------
" UI / behavior
"---------------------------
set number
set relativenumber
set cursorline
set smartindent
set incsearch
set hlsearch
set ignorecase
set showmatch
set showmode
set backspace=indent,eol,start
set title
set ruler
set nowrap
set wrapscan
set wildmenu
set wildmode=list:full
set wildignore-=.*
set wildignore-=*/.*
set undolevels=100
set noswapfile
set nobackup

" Colors
set t_Co=256
"set shortcut keys
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a

" Terminal "transparent" look (works if terminal supports it)
highlight Normal      ctermbg=none
highlight NonText     ctermbg=none
highlight LineNr      ctermbg=none
highlight Folded      ctermbg=none
highlight EndOfBuffer ctermbg=none

"---------------------------
" Tabs / indent
"---------------------------
set expandtab              " Tab -> spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

"settings for kannokanno/previm?
autocmd BufRead,BufNewFile *.md silent set filetype=markdown

"settings for plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

"press <F6> key then insert timstamp and change insert mode.
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d_%H:%M")<CR>

"open a NERDTree automatically when vim starts up
"autocmd vimenter * NERDTree

" Visualization of double-byte spaces, spaces at the end of lines, and tabs. 
"---------------------------
" Whitespace visualization
"---------------------------
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

"---------------------------
" Clipboard
"---------------------------
" Enable clipboard only if supported
if has('clipboard')
  " Prefer unnamedplus if available; otherwise unnamed
  try
    set clipboard^=unnamedplus
  catch
    set clipboard^=unnamed
  endtry
endif

"=========================================================
" Markdown (plasticboy/vim-markdown)
"=========================================================
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = [
  \ 'python',
  \ 'sql',
  \ 'c',
  \ 'cpp',
  \ 'go',
  \ 'bash=sh',
  \ 'yaml',
  \ 'json',
  \ 'terraform',
  \ 'hcl'
\ ]

"=========================================================
" JSON
"=========================================================
let g:vim_json_syntax_conceal = 0

"---------------------------
" Filetype / syntax
"---------------------------
filetype plugin indent on
syntax on

" Keep the current line readable after syntax/colorscheme changes.
if exists('&cursorlineopt')
  set cursorlineopt=both
endif

function! s:ApplyCursorLineHighlight() abort
  highlight CursorLine   term=none cterm=none ctermfg=White ctermbg=238 gui=none guifg=#f0f0f0 guibg=#303030
  highlight CursorLineNr term=bold cterm=bold ctermfg=Yellow ctermbg=238 gui=bold guifg=#ffd75f guibg=#303030
endfunction

augroup my_cursorline
  autocmd!
  autocmd ColorScheme * call s:ApplyCursorLineHighlight()
augroup END

call s:ApplyCursorLineHighlight()

"=========================================================
" NERDTree (manual only, single tree shared across tabs)
"=========================================================
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
let g:NERDTreeChDirMode = 2

" Open/close only when you run the command (no autostart)
nnoremap <silent> <C-e> :NERDTreeTabsToggle<CR>
nnoremap <silent> <Leader>e :NERDTreeTabsFind<CR>

" If only NERDTree remains, quit Vim
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"=========================================================
" coc.nvim (minimal, stable)
"=========================================================
set completeopt=menuone,noselect

" Popup menu navigation (keep your preference)
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"

"=========================================================
" Windows (msys/mingw)
"=========================================================
if has('win32unix')
  vnoremap y "+y
  vnoremap p "+p
endif

"=========================================================
" Misc keymaps
"=========================================================
vnoremap <silent> <C-p> "0p
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d_%H:%M")<CR>

"=========================================================
" Autocmds (grouped / no duplicates)
"=========================================================
augroup my_filetypes
  autocmd!
  " *.md は標準判定に任せる（消す）
  autocmd BufRead,BufNewFile *.txt              setfiletype markdown
  autocmd BufRead,BufNewFile *.json             setfiletype json
  autocmd BufRead,BufNewFile Dockerfile*        set syntax=dockerfile
  autocmd BufRead,BufNewFile */playbooks/*.yml  setfiletype yaml.ansible
augroup END

"=========================================================
" Statusline (keep fugitive branch)
"=========================================================
set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{fugitive#statusline()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%#CursorColumn#
set statusline+=%y
set statusline+=[ENC=%{&fileencoding}]
set statusline+=[ROW=%l/%L]
set statusline+=%r
set statusline+=[%p%%]
set statusline+=\ [%o/%{wordcount().bytes}]

"=========================================================
" Profiling (startup measurement)
"=========================================================
command! Profile call s:command_profile()
function! s:command_profile() abort
  profile start ~/profile.txt
  profile func *
  profile file *
endfunction

"=========================================================
" diffopt
"=========================================================
set diffopt+=context:10000

" リーダーキー定義
let mapleader = " "

" <Space> w が <C-w> になる
nnoremap <Leader>w <C-w>

""ターミナル用
tnoremap <Leader>w <C-\><C-n><C-w>w

"補完設定
set wildmenu

colorscheme desert
