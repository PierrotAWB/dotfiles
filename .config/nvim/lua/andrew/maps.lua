local function map(m, k, v, opt)
    opt = opt or { silent = true }
    vim.keymap.set(m, k, v, opt)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Centre searches, jumps, scrolls.
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-i>', '<C-i>zz')
map('n', '<C-o>', '<C-o>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- Better window navigation
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')

-- Fzf-lua
map('n', 'g/', "<cmd>lua require('fzf-lua').live_grep()<CR>")
map('n', '<leader><leader>', "<cmd>lua require('fzf-lua').files()<CR>")
map('n', '<leader>cs', "<cmd>lua require('fzf-lua').colorschemes()<CR>")
map('n', '<leader>h', "<cmd>lua require('fzf-lua').oldfiles()<CR>")
map('n', '<leader>he', "<cmd>lua require('fzf-lua').help_tags()<CR>")
map('n', '<C-z>', '<Nop>')

-- LSP (Using fzf-lua)
map('n', 'gd', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>")
map('n', 'gr', "<cmd>lua require('fzf-lua').lsp_references()<CR>")
map('n', 'gi', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>")
map('n', '<leader>ca', "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>")

-- Fugitive
map('n', 'ga', ':Git add ', { silent = false })
map('n', 'gC', ':Git commit ', { silent = false })
map('n', 'gl', ':Git log<CR>')
map('n', 'gs', ':Git status<CR>')

-- Misc.
map('n', '<leader>.', ':tabe $MYVIMRC<CR>')
map('n', '<leader>c', ':Corpus ', { silent = false })
map('n', '<leader>f', ':NvimTreeToggle<CR>')
map('n', '<leader>gq', 'mzggvGgq`z')
map('n', '<leader>M', ':!sudo make install<CR>')
map('n', '<leader>o', ':only<CR>')
map('n', '<leader>sp', ':set spell!<CR>')
map('n', '<leader>sv', ':source $MYVIMRC<CR>')
map('n', '<leader>t', ':10split | terminal<CR>')
map('n', '<leader>tf', ':NvimTreeFindFile<CR>')
map('n', '<leader>toc', '<Plug>(coc-codeaction-source)')
map('n', '<leader>u', ':UndotreeToggle<CR>')
map('n', '<leader>vt', ':80vsplit | terminal<CR>')
map('n', '<leader>z', ":ZenMode<CR>")

map('t', '<Esc>', '<C-\\><C-n>')

