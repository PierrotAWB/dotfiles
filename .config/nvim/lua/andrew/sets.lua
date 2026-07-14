vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- General appearance
vim.o.background = 'light'
vim.o.colorcolumn = '80'
vim.o.cursorline = true
vim.o.cursorlineopt = 'number' -- Mark the cursor line via its number only, not a full-width band
vim.o.guicursor = 'i-ci-ve:hor50-blinkwait0-blinkoff100-blinkon100'
vim.o.termguicolors = true
vim.o.laststatus = 3           -- Single global statusline
vim.opt.fillchars:append {
    eob = ' ',  -- Kill the ~ tildes on empty lines below the buffer
    diff = '╱', -- Diagonal fill for deleted/absent diff regions (vs default dashes)
    vert = '│',
    fold = ' ',
}

-- Gutter
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes' -- Always reserve the sign column (no text jitter)

-- Indent
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd [[filetype plugin indent on]]

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tabbing
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Misc.
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99
vim.o.foldlevel = 99
vim.o.mouse = "nv"
vim.o.scrolloff = 10
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeoutlen = 250
vim.o.clipboard = 'unnamedplus'

-- Ultisnips
vim.g.UltiSnipsEditSplit = 'horizontal'
vim.g.UltiSnipsExpandTrigger = '<nop>'
vim.g.UltiSnipsJumpForwardTrigger = '<nop>'
vim.g.UltiSnipsJumpBackwardTrigger = '<nop>'

-- Vimtex
vim.g.vimtex_view_method = 'skim'
