require('dashboard').setup {
    theme = 'hyper',
    config = {
        header = {
            '',
            '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
            '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
            '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
            '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
            '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
            '',
            'Simplicity is the soul of efficiency. — Austin Freeman',
            '',
        },
        shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'PackerSync', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = function()
                    require('fzf-lua').files({
                        file_icons = false,
                        git_icons = false,
                    })
                end,
                key = 'f',
            },
            {
                desc = ' Apps',
                group = 'DiagnosticHint',
                action = 'Mason',
                key = 'a',
            },
            {
                desc = ' dotfiles',
                group = 'Number',
                action = function()
                    require('fzf-lua').files({
                        cwd = vim.fn.stdpath('config'),
                        file_icons = false,
                        git_icons = false,
                    })
                end,
                key = 'd',
            },
        },
        packages = { enable = true },
        project = {
            enable = true,
            limit = 8,
            icon = ' ',
            label = 'Recent Projects:',
            action = function(path)
                vim.cmd('tcd ' .. vim.fn.fnameescape(path))
            end,
        },
        mru = {
            enable = true,
            limit = 10,
            icon = ' ',
            label = 'Most Recent Files:',
            cwd_only = false,
        },
        footer = { '', '🚀 Sharp tools make good work.' },
    },
}
