set nocompatible              " be iMproved, required
set nrformats=                 " treats all numbers as decimal numbers, whether they are prefixed with 0 or not
call plug#begin()
" !! write Plugs here !!
Plug 'plugVim/plug.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Automatically show Vim's complete menu while typing.
Plug 'vim-scripts/AutoComplPop'
Plug 'WolfgangMehner/bash-support'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Plug for terraform tf files
Plug 'hashivim/vim-terraform'
" Plug for json files
Plug 'elzr/vim-json'
" Plug for markdown toc
Plug 'mzlogin/vim-markdown-toc'
" Plug for csv
Plug 'mechatroner/rainbow_csv'
" Plug for C
Plug 'justmao945/vim-clang'
" Plug for go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug for python
" 'davidhalter/jedi-vim'
" twitter
" All of your Plugins must be added before the following line
call plug#end()

let g:vim_markdown_folding_style_pythonic = 1
" Don't indent when adding a list
let g:vim_markdown_new_list_item_indent = 0

"backticks always visible
let g:vim_markdown_conceal = 0

filetype plugin on    " required
filetype indent on    " required
filetype on    " required

"encoding
let $LANG='ja_JP.UTF-8'
set encoding=utf-8
set fileencodings=utf-8,cp932
set fileformats=unix,dos,mac
set cursorline  "Highlight the current line.
set smartindent "Smart indentation
syntax on       "Show syntax color 
"set number      "Show line number 
set relativenumber      "Show line number(relative) 
set number      "Show line number 
set incsearch   "Incremental search 
set ignorecase  " Search regardless of case
set showmatch   "Emphasize the corresponding parentheses when entering parentheses
set showmode    "Show mode
set backspace=2 "Newlines and indents can now be removed with backspace
set title       "Show the name of the file being edited
set ruler       "Show the ruler (which displays the number of lines in the lower right corner)
set shiftwidth=4 "Number of tabs at line break for autoindent
set expandtab "Don't replace tabs with spaces
set tabstop=2 "Display width for Tab characters other than at the beginning of a line
set shiftwidth=2 "Display width of the Tab character at the beginning of a line
set noswapfile  "Don't create a swap file
set nobackup    "Don't create a backup file
set hlsearch    "Highlight search results
set wrapscan    "When you reach the end of the search results, search again from the beginning
set wildmenu wildmode=list:full   "Enhanced completion functions
set nowrap        "No wrapping of long lines
set undolevels=100 "Number of undoable items
set cursorline "draw a horizontal line
"disable folding
set nofoldenable    " disable folding
"colorscheme molokai
colorscheme desert
set t_Co=256
"set shortcut keys
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a

"For AutoCompletion
let g:apc_enable_ft = {'*':1}
set cpt=.,k,w,b
set complete+=kspell
"set completeopt=menuone,longest
set completeopt=menu,menuone,noselect,longest
set shortmess+=c

"Change settings by file extension
autocmd BufNewFile,BufRead *.{md,txt} silent setlocal filetype=markdown 
autocmd BufNewFile,BufRead *.{md,txt} silent
"vim background transparency
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 

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
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" show hidden files
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>

" Show tree by default in newtab
"let g:nerdtree_tabs_open_on_console_startup=1

" If NERDTree is open when all other buffers are closed, close NERDTree together
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" For json settings
autocmd BufNewFile,BufRead *.json set filetype=json
let g:vim_json_syntax_conceal = 0

" Clipboard cooperation between vim and desktop
set clipboard&
set clipboard^=unnamedplus

"For AutoCompletion
" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
" Select the complete menu item like CTRL+y would.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"
" Cancel the complete menu item like CTRL+e would.
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" vim yank settings for mingw32
if has('win32unix')
"  vnoremap "*y :'<,'>w !cat > /dev/clipboard
  vnoremap y "+y
  vnoremap p "+p
endif

" "0p paste keymap
vnoremap <silent> <C-p> "0p<CR>

" for dockerfile syntax
autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile

" For completion deoplete plugin
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#force_omni_input_patterns')
    let g:deoplete#force_omni_input_patterns = {}
endif

let g:deoplete#force_overwrite_completefunc = 1
let g:deoplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For clang
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'
let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'
"let g:clang_c_options = '-std=c11'
let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++ --pedantic-errors'

set laststatus=2  " Show statusline always
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{fugitive#statusline()} "Show GitBranch
set statusline+=%#LineNr#
set statusline+=\ %f  " Show file name
set statusline+=%m "Check indication of changes
set statusline+=%#CursorColumn#
set statusline+=%y  " Show file type
set statusline+=[ENC=%{&fileencoding}] " Show fileencoding
set statusline+=[LOW=%l/%L] "Show current row count/total row count
set statusline+=%r  " Show readonly flag
set statusline+=[%p%%] "Show current line percentage
set statusline+=%#lite#[%o/%{wordcount().bytes}] "Show number of characters where current cursor characters is./ Show total number of characters

"vim startup measurement
command! Profile call s:command_profile()
function! s:command_profile() abort
  profile start ~/profile.txt
  profile func *
  profile file *
endfunction

