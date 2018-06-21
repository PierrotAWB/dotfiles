execute pathogen#infect()
syntax on

"""""""""""""""""""""""""""""""""""""""""" ENVIRONMENT CONFIGURATIONS

set incsearch
set relativenumber

" GUI Font for Powerline
set guifont=InputMono-RegularForPowerline

" New symbols in Powerline:
let g:Powerline_symbols='fancy'

" Powerline to work not only in split
set laststatus=2

" Default colour scheme
colors zenburn

" Use relative line numbering outside
" of insert and absolute within.
au InsertEnter * :set number
au InsertLeave * :set relativenumber

"""""""""""""""""""""""""""""""""""""""""" KEYMAPPINGS

" To save, command-s
nmap <D-s> :w<CR>
imap <D-s> <Esc>:w<Cr>a

" To alternate folds, use space (normal mode)
nmap <space> za

"""""""""""""""""""""""""""""""""""""""""" VIM LATEX

" REQUIRED. This makes vim invoke Latex
" -Suite when you open a tex file.
filetype plugin on


" " IMPORTANT: win32 users will need to
" have 'shellslash' set so that latex
" " can be called correctly.
set shellslash

" " OPTIONAL: This enables automatic
" indentation as you type.
filetype indent on


" " OPTIONAL: Starting with Vim 7, the
" filetype of empty .tex files defaults
" to 'plaintex' instead of 'tex', which
" results in vim-latex not being loaded.
"
" The following changes the default 
" filetype back to 'tex':
let g:tex_flavor='latex'

" DEFAULT Output viewer (Mac OS)
let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'
