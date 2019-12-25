"           /$$
"          |__/
" /$$    /$$/$$ /$$$$$$/$$$$   /$$$$$$  /$$$$$$$
"|  $$  /$$/ $$| $$_  $$_  $$ /$$__  $$/$$_____/
" \  $$/$$/| $$| $$ \ $$ \ $$| $$  \__/ $$
"  \  $$$/ | $$| $$ | $$ | $$| $$     | $$
"   \  $/  | $$| $$ | $$ | $$| $$     |  $$$$$$$
"    \_/   |__/|__/ |__/ |__/|__/      \_______/

execute pathogen#infect()

filetype plugin on
filetype indent on
syntax on

"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE

set autoindent
set confirm 
set cmdheight=2
set incsearch
set iskeyword+=:
set laststatus=2
set nocompatible
set mouse=a
set number
set relativenumber
set rtp+=/usr/share/powerline/bindings/vim
set shellslash
set shiftwidth=4
set tabstop=4
set termguicolors
set t_Co=256
set updatetime=500
"set visualbell

set timeoutlen=1000
set ttimeoutlen=0

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme Synthwave "OceanicNext Sidonia

"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

let g:ale_fix_on_save = 1
let g:livepreview_engine = 'pdflatex'
let g:livepreview_previewer = 'open -a Preview'
let g:Powerline_symbols='fancy'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:tex_flavor = 'latex'
let g:Tex_GotoError=0
"let g:Tex_ViewRule_pdf = 'zathura'
let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

let g:UltiSnipsUsePythonVersion = 3


inoremap jk <Esc>
"
"  _              _     _           _ _                 
" | |            | |   (_)         | (_)                
" | | _____ _   _| |__  _ _ __   __| |_ _ __   __ _ ___ 
" | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
" |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
" |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"           __/ |                             __/ |     
"           |___/                             |___/     

" Note: mappings are temporarily to control; it seems very difficult to map to
" command in the terminal. What's more, using control conflicts with XOFF;
" using it tends to freeze the current terminal window.

" Navigate to front and end of line in normal mode
nmap <C-a> ^
nmap <C-e> $ 

" Navigate to front and end of line in insert mode
imap <C-a> <Esc>I
imap <C-e> <Esc>A

" Delete everything from the cursor to the end of the line
nmap <C-k> lD
imap <C-k> <Esc>2ld$a

" Delete everything from beginning of the line to the cursor
nmap <C-u> d^x
imap <C-u> <Esc>d^xi

" To undo, option-z
nnoremap <C-z> :undo<CR>
inoremap <C-z> <Esc>:undo<CR>

" To redo, option-y
nnoremap <C-y> :redo<CR>
inoremap <C-y> <Esc>:redo<CR>

" To write-quit, option-w
nnoremap <C-w> :wq<CR>
inoremap <C-w> <Esc>:wq<Cr>

" Strictly map escape key
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap jk <Esc>

" Map ctrl-l to :LLP (Live Preview)
imap <C-l> <Esc>:LLP
nmap <C-l> :LLP

" To alternate folds, use space (normal mode)
nmap <space> za


" Autocommand 
au BufReadPost,BufNewFile *.md,*.txt,*.tex setlocal nofoldenable

