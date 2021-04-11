source $XDG_CONFIG_HOME/vim/autoload/plug.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Default settings                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on
filetype indent on
syntax on

"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE

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
set path+=**
set relativenumber
set rtp+=$XDG_CONFIG_HOME/vim/autoload
set shellslash
set shiftwidth=4
set splitbelow
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Global variables                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:livepreview_engine = 'pdflatex'
let g:livepreview_previewer = 'zathura'
let g:Powerline_symbols='fancy'
let g:Tex_CompileRule_pdf = 'latexmk -pdf -f $*'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:tex_flavor = 'latex'
let g:Tex_GotoError=0
let g:Tex_ViewRule_pdf = 'zathura'

let g:netrw_banner=0
let g:netrw_dirhistmax=0

let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:conceallevel=1
let g:tex_conceal='abdmg'

let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsSnippetDirectories=[$XDG_CONFIG_HOME.'/vim/plugged/ultisnips']

let g:UltiSnipsUsePythonVersion = 3


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Keybindings                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Toggle Canadian English spell check
nmap <F6> :set spell! spelllang=en_ca<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/vim/plugged')

Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'neomake/neomake'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               File Settings                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au BufReadPost,BufNewFile *.md,*.txt,*.tex setlocal nofoldenable
au FileType tex setlocal syntax=off

"  Run a program in terminal.
autocmd filetype py nnoremap <F4> :w <bar> exec ':term python %'<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec ':term gcc % -o %:r'<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec ':term g++ % -o %:r'<CR>

" (un)comment blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END

" TODO: Fix commenting in a block that already contains some comments.
function! ToggleComment()
  if exists("b:comment_leader") == 0
    throw "No comment leader found for filetype."
  else
    if getline('.') =~ '^\s*' . b:comment_leader
      " Uncomment the line
      execute 'silent s/\v^(\s*)' . b:comment_leader . '(\s*)/\1\2/'
    else
      " Comment the line
      execute 'silent! s/\v^(\s*)/' . b:comment_leader . '\1/'
    endif
  endif
endfunction
   
nnoremap <C-_> :call ToggleComment()<CR>
vnoremap <C-_> :call ToggleComment()<CR>
