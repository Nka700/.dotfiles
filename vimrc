set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" !! write plugins here !!
Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_style_pythonic = 1
" TableFormatはよく使うのでエイリアス
:command TF TableFormat
" list追加時のindentは行わない
let g:vim_markdown_new_list_item_indent = 0

Plugin 'scrooloose/nerdtree'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'
Plugin 'https://github.com/twitvim/twitvim.git'
Plugin 'TwitVim'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'leshill/vim-json'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
" Automatically show Vim's complete menu while typing.
Plugin 'vim-scripts/AutoComplPop'
Plugin 'WolfgangMehner/bash-support'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
" Plugin for terraform tf files
Plugin 'hashivim/vim-terraform'
" Plugin for json files
Plugin 'elzr/vim-json'
" Plugin for markdown toc
Plugin 'mzlogin/vim-markdown-toc'
" Plugin for csv
Plugin 'mechatroner/rainbow_csv'
" Plugin for C
Plugin 'justmao945/vim-clang'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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
set statusline+=%<%F  " Show file name
syntax on       "Show syntax color 
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
set statusline+=%m "Check indication of changes
"colorscheme molokai
colorscheme desert
set t_Co=256
"set shortcut keys
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a

"For AutoCompletion
set complete+=kspell
set completeopt=menuone,longest
set shortmess=c
      
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

"preview ctrl + p
"nnoremap <silent> <C-p> :PrevimOpen<CR>

"enable python for Twitvim
let twitvim_enable_python3 = 1

"settings for plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

"press <F6> key then insert timstamp and change insert mode.
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d %H:%M")<CR>

"open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree

" Visualization of double-byte spaces, spaces at the end of lines, and tabs. 
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" show hidden files
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>

" Show tree by default in newtab
let g:nerdtree_tabs_open_on_console_startup=1

" If NERDTree is open when all other buffers are closed, close NERDTree together
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" For json settings
autocmd BufNewFile,BufRead *.json set filetype=json
let g:vim_json_syntax_conceal = 0

" Powerline系フォントを利用する
set laststatus=2
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'ayu_dark'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" Remap <ESC> to jk
"inoremap jk <ESC>

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

" For neocompletion plugin
"let g:neocomplete#enable_at_startup = 1
"if !exists('g:neocomplete#force_omni_input_patterns')
"    let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_overwrite_completefunc = 1
"let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

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
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ -pedantic-errors'



