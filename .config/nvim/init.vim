syntax enable					" Necessary for vimtex.
filetype plugin indent on			" Necessary for vimtex.

let mapleader = ","

set clipboard=unnamedplus			" Copy to system clipboard by default.
set guicursor=i-ci-ve:hor50-blinkwait0-blinkoff100-blinkon100 
set mouse=nv					" Mouse on in normal and visual modes.
set number					" Line number on focused row.
set relativenumber				" Displays distance to adjacent rows.
set splitright					" Opens vertical splits on right side.
set termguicolors				" Enables 24-bit RGB colors.

colorscheme iceberg

" Fzf Buffers map gb :Buffers<CR>
" Ripgrep 
map g/ :Rg<CR>
" Filename search
map <space><space> :Files<CR>
" Prevent accidental crashes
map <C-z> <Nop>

nmap ga :Git add 
" Prevent collision with commenting (gc).
nmap gC :Git commit 
nmap gl :Git log<CR>
nmap gs :Git status<CR>

" Jumping and Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gY :call CocAction('jumpTypeDefinition', 'split')<CR>
nmap <silent> gr <Plug>(coc-references)

let g:UltiSnipsEditSplit="horizontal"		" Split window when editting snippets.
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"	" Don't hijack digraphs.
let g:matchup_matchparen_deferred=1		" Deferred highlighting helps cursor lag.
let g:matchup_override_vimtex=1			" Cursor lag in vimtex.
let g:vimtex_view_method='zathura'		" Default PDF viewer.

call plug#begin(stdpath('data') . '/plugged')
	Plug 'andymass/vim-matchup'		" vimtex syntax speed up.
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 	Plug 'junegunn/fzf.vim'
	Plug 'lervag/vimtex'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}	" LSP
	Plug 'romainl/vim-cool'			" Unhighlight when done searching
	Plug 'sbdchd/neoformat'
	Plug 'SirVer/ultisnips'
	Plug 'tpope/vim-commentary'		" Commenting
	Plug 'tpope/vim-fugitive'		" Git
call plug#end()
