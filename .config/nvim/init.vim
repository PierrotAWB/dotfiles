syntax enable					" Necessary for vimtex.
filetype plugin indent on			" Necessary for vimtex.

let mapleader = ","

set clipboard=unnamedplus			" Copy to system clipboard by default.
set guicursor=i-ci-ve:hor50-blinkwait0-blinkoff100-blinkon100
set mouse=nv					" Mouse on in normal and visual modes.
set number					" Line number on focused row.
set relativenumber				" Displays distance to adjacent rows.
set scrolloff=10				" Permanent zz.
set splitright					" Opens vertical splits on right side.
set termguicolors

" Fzf Buffers map gb :Buffers<CR>
" Ripgrep
map g/ :Rg<CR>
" Filename search
map <space><space> :Files<CR>
" Prevent accidental crashes
map <C-z> <Nop>
" Move lines, then re-indent
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

nmap ga :Git add
" Prevent collision with commenting (gc).
nmap gC :Git commit
nmap gl :Git log<CR>
nmap gs :Git status<CR>

" Compile current file.
nnoremap <leader>c :w \| !compiler %<CR>
" Open preview (after compilation).
nnoremap <leader>p :!opout %<CR><CR>
" Re-wrap entire file
nnoremap <leader>gq mzggvGgq`z
" Toggle spell check
nnoremap <leader>sp :set spell!<CR>
" Centre lone buffers
nnoremap <silent><leader>z <cmd>Goyo<CR>
" Source init.vim without exiting nvim
nnoremap <leader>sv :source $MYVIMRC<CR>

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

" Compile on save
autocmd BufWritePost *.md silent! !compiler %
" On save, delete trailing whitespace, then reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

call plug#begin(stdpath('data') . '/plugged')
	Plug 'andymass/vim-matchup'		" vimtex syntax speed up.
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/goyo.vim'		" Zen mode
	Plug 'lervag/vimtex'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}	" LSP
	Plug 'romainl/vim-cool'			" Unhighlight when done searching
	Plug 'sbdchd/neoformat'
	Plug 'SirVer/ultisnips'
	Plug 'tpope/vim-commentary'		" Commenting
	Plug 'tpope/vim-fugitive'		" Git
call plug#end()

colorscheme iceberg
