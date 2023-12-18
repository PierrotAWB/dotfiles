-- Run PackerInstall on save of this file.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerInstall',
})

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'andymass/vim-matchup'
    use 'ibhagwan/fzf-lua'
    use 'folke/zen-mode.nvim'
    use 'mbbill/undotree'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'romainl/vim-cool'     -- Unhighlight when done searching
    use 'tpope/vim-commentary' -- Commenting
    use 'tpope/vim-fugitive'   -- Git
    use 'wincent/corpus'       -- Note-taking
    use { 'SirVer/ultisnips', opt = false }
    use 'lervag/vimtex'
    use 'zdcthomas/yop.nvim'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        "windwp/nvim-ts-autotag",
        config = function() require("nvim-ts-autotag").setup {} end
    }

    -- Colors
    use 'Alexis12119/nightly.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'kaicataldo/material.vim'
    use 'PierrotAWB/neovim-ayu'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
end)
