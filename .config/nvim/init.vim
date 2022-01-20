syntax enable					" Necessary for vimtex.
filetype plugin indent on			" Necessary for vimtex.

set cursorline					" Highlight line under (active) cursor.
set guicursor=i-ci-ve:hor50-blinkwait0-blinkoff100-blinkon100 
set mouse=nv					" Mouse on in normal and visual modes."
set number					" Line number on focused row.
set relativenumber				" Displays distance to adjacent rows.
set splitright					" Opens vertical splits on right side.
set termguicolors				" Enables 24-bit RGB colors.
set ttimeoutlen=50				" Used when command is a prefix of another.

colorscheme iceberg

" The '|' allows us to write in-line comments.
map g/ :Rg<CR>|					" Ripgrep
map <space><space> :Files<CR>|			" Filename search
map gb :Buffers<CR>|				" Fzf Buffers
map <C-z> <Nop>|				" Prevent accidental crashes

let g:UltiSnipsEditSplit="horizontal"		" Split window when editting snippets.
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"	" Don't hijack digraphs.
let g:matchup_matchparen_deferred=1		" Deferred highlighting helps cursor lag.
let g:matchup_override_vimtex=1			" Cursor lag in vimtex.
let g:vimtex_view_method='zathura'		" Default PDF viewer.

call plug#begin(stdpath('data') . '/plugged')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 	Plug 'junegunn/fzf.vim'
	Plug 'SirVer/ultisnips'
	Plug 'lervag/vimtex'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'
	Plug 'andymass/vim-matchup'		" vimtex syntax speed up.
call plug#end()

" Set CursorLine only on the currently focused window.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
