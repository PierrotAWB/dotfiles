"           /$$
"          |__/
" /$$    /$$/$$ /$$$$$$/$$$$   /$$$$$$  /$$$$$$$
"|  $$  /$$/ $$| $$_  $$_  $$ /$$__  $$/$$_____/
" \  $$/$$/| $$| $$ \ $$ \ $$| $$  \__/ $$
"  \  $$$/ | $$| $$ | $$ | $$| $$     | $$
"   \  $/  | $$| $$ | $$ | $$| $$     |  $$$$$$$
"    \_/   |__/|__/ |__/ |__/|__/      \_______/

source $XDG_CONFIG_HOME/vim/autoload/plug.vim

filetype plugin on
filetype indent on
syntax on

"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE

" Vim behaviour and appearance
set autoindent
set backspace=indent,eol,start
set confirm 
set cmdheight=2
set incsearch
set iskeyword+=:
set laststatus=2
set nocompatible
set mouse=a
set nocp
set number
set relativenumber
set rtp+=/home/andrew/.config/vim/autoload
set shellslash
set shiftwidth=4
set tabstop=4
set termguicolors
set t_Co=256
set updatetime=500
"#set visualbell
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo

set timeoutlen=1000
set ttimeoutlen=0

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

highlight LineNr ctermfg=red

" Plugin Settings
let g:livepreview_engine = 'pdflatex'
let g:livepreview_previewer = 'zathura'
let g:Powerline_symbols='fancy'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:tex_flavor = 'latex'
let g:Tex_GotoError=0
let g:Tex_ViewRule_pdf = 'zathura'

let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=[$XDG_CONFIG_HOME.'/vim/plugged/ultisnips']

let g:UltiSnipsUsePythonVersion = 3


"
"  _              _     _           _ _                 
" | |            | |   (_)         | (_)                
" | | _____ _   _| |__  _ _ __   __| |_ _ __   __ _ ___ 
" | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
" |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
" |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"           __/ |                             __/ |     
"           |___/                             |___/     

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

" To save, control-s
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" To undo, control-z
nnoremap <C-z> :undo<CR>
inoremap <C-z> <Esc>:undo<CR>

" To redo, control-y
nnoremap <C-y> :redo<CR>
inoremap <C-y> <Esc>:redo<CR>

" Strictly map escape key
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap jk <Esc>

" Map ctrl-l to :LLP (Live Preview)
imap <C-l> <Esc>:LLP
nmap <C-l> :LLP

" To alternate folds, use space (normal mode)
nmap <space> za


"______ _             _           
"| ___ \ |           (_)          
"| |_/ / |_   _  __ _ _ _ __  ___ 
"|  __/| | | | |/ _` | | '_ \/ __|
"| |   | | |_| | (_| | | | | \__ \
"\_|   |_|\__,_|\__, |_|_| |_|___/
"                __/ |            
"               |___/             

call plug#begin('~/.config/vim/plugged')

Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'neomake/neomake'

call plug#end()


"______ _ _          _____      _   _   _                 
"|  ___(_) |        /  ___|    | | | | (_)                
"| |_   _| | ___    \ `--.  ___| |_| |_ _ _ __   __ _ ___ 
"|  _| | | |/ _ \    `--. \/ _ \ __| __| | '_ \ / _` / __|
"| |   | | |  __/   /\__/ /  __/ |_| |_| | | | | (_| \__ \
"\_|   |_|_|\___|   \____/ \___|\__|\__|_|_| |_|\__, |___/
"                                                __/ |    
"                                               |___/     

au BufReadPost,BufNewFile *.md,*.txt,*.tex setlocal nofoldenable
au FileType tex setlocal syntax=off

