syntax enable					" Necessary for vimtex.
filetype plugin indent on			" Necessary for vimtex.

call plug#begin(stdpath('data') . '/plugged')
	Plug 'andymass/vim-matchup'		" vimtex syntax speed up.
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/goyo.vim'		" Zen mode
	Plug 'lervag/vimtex'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}	" LSP
	Plug 'PierrotAWB/corpus'		" Note taking
  	Plug 'preservim/nerdtree'		" File browsing
	Plug 'romainl/vim-cool'			" Unhighlight when done searching
	Plug 'sbdchd/neoformat'
	Plug 'Shatur/neovim-ayu'
	Plug 'SirVer/ultisnips'
	Plug 'tpope/vim-commentary'		" Commenting
	Plug 'tpope/vim-fugitive'		" Git
call plug#end()

let mapleader = ","

set background=light
set clipboard=unnamedplus			" Copy to system clipboard by default.
set cursorline					" Highlight current row.
set foldmethod=indent				" Faster than syntax.
set guicursor=i-ci-ve:hor50-blinkwait0-blinkoff100-blinkon100
set mouse=nv					" Mouse on in normal and visual modes.
set number					" Line number on focused row.
set relativenumber				" Displays distance to adjacent rows.
set scrolloff=10				" Permanent zz.
set splitbelow splitright			" Better default splitting directions
set termguicolors
set undofile					" Undo persistence

:command IO :vsp input.in | :sp output.out

" Fzf Buffers map gb :Buffers<CR>
" Ripgrep
map g/ :Rg<CR>
" Filename search
map <space><space> :Files<CR>
" Prevent accidental crashes
map <C-z> <Nop>
" Move lines, then re-indent
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==

" Better window navigation
nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-l> <C-w><C-l>

nmap ga :Git add
" Prevent collision with commenting (gc).
nmap gC :Git commit
nmap gl :Git log<CR>
nmap gs :Git status<CR>

tnoremap <Esc> <C-\><C-n>

" Toggle background darkness
nnoremap <leader>b :call Toggle_dark()<CR>
" Show commands
nnoremap <leader>c :Commands<CR>
" Compile current file.
nnoremap <leader>C :w \| !compiler %<CR>
" Format code
nnoremap <leader>f :call CocActionAsync('format')<CR>
" NERDTreeFind
nnoremap <leader>F :NERDTreeFind<CR>
" Format code
nnoremap <leader>h :History<CR>
" Open preview (after compilation).
nnoremap <leader>p :!opout %<CR><CR>
" Re-wrap entire file
nnoremap <leader>gq mzggvGgq`z
" Make install
nnoremap <leader>m :!make -f $CONTEST/Makefile<CR>
nnoremap <leader>M :!sudo make install<CR>
" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" Toggle spell check
nnoremap <leader>o :only<CR>
nnoremap <leader>sp :set spell!<CR>
" Source init.vim without exiting nvim
nnoremap <leader>sv :source $MYVIMRC<CR>
" Open terminal (horizontal split)
nnoremap <leader>t :10split \| terminal<CR>
" Open terminal (vertical split)
nnoremap <leader>vt :vsplit \| :terminal<CR>
" Centre lone buffers
nnoremap <silent><leader>z <cmd>Goyo<CR>

nnoremap <Space>c :Corpus<Space>

" Jumping and Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gY :call CocAction('jumpTypeDefinition', 'split')<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <F6> <Plug>(coc-rename)

let g:UltiSnipsEditSplit="horizontal"		" Split window when editting snippets.
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"	" Don't hijack digraphs.
let g:matchup_matchparen_deferred=1		" Deferred highlighting helps cursor lag.
let g:matchup_override_vimtex=1			" Cursor lag in vimtex.
let g:vimtex_view_method='zathura'		" Default PDF viewer.

fun! Toggle_dark()
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfun

" Compile on save
autocmd BufWritePost *.md silent! !compiler %
" On save, delete trailing whitespace, then reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Disable continuation of comments on newline.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

colorscheme ayu-mirage

let g:CorpusDirectories={
	\ 	'~/documents/notes/': {
	\ 	  'autoreference': 1,
	\ 	  'autotitle': 1,
	\	  'base': './',
	\	  'transform': 'local'
	\	}
	\ }
