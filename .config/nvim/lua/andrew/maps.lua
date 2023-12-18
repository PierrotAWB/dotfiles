function Map(m, k, v, opt)
    opt = opt or { silent = true }
    vim.keymap.set(m, k, v, opt)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Centre searches, jumps, scrolls.
Map('n', '<C-f>', '<C-f>zz')
Map('n', '<C-b>', '<C-b>zz')
Map('n', '<C-d>', '<C-d>zz')
Map('n', '<C-u>', '<C-u>zz')
Map('n', '<C-y>', '<C-y>zz')
Map('n', '<C-e>', '<C-e>zz')
Map('n', '<C-i>', '<C-i>zz')
Map('n', '<C-o>', '<C-o>zz')
Map('n', 'n', 'nzz')
Map('n', 'N', 'Nzz')

-- Better window navigation
Map('n', '<C-h>', '<C-w><C-h>')
Map('n', '<C-j>', '<C-w><C-j>')
Map('n', '<C-k>', '<C-w><C-k>')
Map('n', '<C-l>', '<C-w><C-l>')

-- Fzf-lua
Map('n', 'g/', "<cmd>lua require('fzf-lua').live_grep({ exec_empty_query = true })<CR>")
Map('n', '<leader><leader>', "<cmd>lua require('fzf-lua').files()<CR>")
Map('n', '<leader>ke', "<cmd>lua require('fzf-lua').keymaps()<CR>")
Map('n', '<leader>cs', "<cmd>lua require('fzf-lua').colorschemes()<CR>")
Map('n', '<leader>h', "<cmd>lua require('fzf-lua').oldfiles()<CR>")
Map('n', '<leader>he', "<cmd>lua require('fzf-lua').help_tags()<CR>")
Map('n', '<C-z>', '<Nop>')

-- LSP (Using fzf-lua) (jump ../../after/plugin/fzf-lua.lua)

-- Vimtex
Map('n', '\\ll', ":VimtexCompile<CR>")
Map('n', '\\lv', ":VimtexView<CR>")

-- Fugitive
Map('n', 'ga', ':Git add ', { silent = false })
Map('n', 'gC', ':Git commit ', { silent = false })
Map('n', 'gl', ':Git log<CR>')
Map('n', 'gs', ':Git status<CR>')
Map('n', 'gvd', ':Gvdiffsplit!<CR>')
Map('n', ']c', '/=======<CR>:diffget //', { silent = false })

-- Misc.
Map('n', '<leader>.', ':tabe $MYVIMRC<CR>')
Map('n', '<leader>c', ':Corpus ', { silent = false })
Map('n', '<leader>f', ':NvimTreeToggle<CR>')
Map('n', '<leader>g', ':Git<CR>')
Map('n', '<leader>gq', 'mzggvGgq`z')
Map('n', '<leader>M', ':!sudo make install<CR>')
Map('n', '<leader>o', ':only<CR>')
Map('n', '<leader>sp', ':set spell!<CR>')
Map('n', '<leader>sv', ':source $MYVIMRC<CR>')
Map('n', '<leader>t', ':10split | terminal<CR>')
Map('n', '<leader>td', ':vs ~/Documents/notes/todo.md<CR>')
Map('n', '<leader>tf', ':NvimTreeFindFile<CR>')
Map('n', '<leader>toc', '<Plug>(coc-codeaction-source)')
Map('n', '<leader>u', ':UndotreeToggle<CR>')
Map('n', '<leader>vt', ':80vsplit | terminal<CR>')
Map('n', '<leader>w', ':wqa<CR>')
Map('n', '<leader>z', ":ZenMode<CR>")

Map('t', '<Esc>', '<C-\\><C-n>')
