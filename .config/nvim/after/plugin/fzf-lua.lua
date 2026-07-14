-- Modified from max-perf
local actions = require 'fzf-lua.actions'
require('fzf-lua').setup({
    actions = {
        files = {
            ["default"] = actions.file_edit,
            ["ctrl-x"]  = actions.file_split,
            ["ctrl-s"]  = actions.file_split,
            ["ctrl-v"]  = actions.file_vsplit,
            ["ctrl-t"]  = actions.file_tabedit,
        },
        buffers = {
            ["default"] = actions.buf_edit,
            ["ctrl-x"]  = actions.buf_split,
            ["ctrl-s"]  = actions.buf_split,
            ["ctrl-v"]  = actions.buf_vsplit,
            ["ctrl-t"]  = actions.buf_tabedit,
        },
    },
    default = {
        global_git_icons = false,
        global_file_icons = false,
    },
    previewers = {
        bat = {
            cmd = "bat",
            args = "--style=numbers,changes --color always",
            theme = 'Coldark-Dark', -- or your preferred theme
        },
    },
    files = { fzf_opts = { ["--ansi"] = false } },
    fzf_opts = { ['--layout'] = 'default' },
    winopts = { preview = { default = "bat" } },
    manpages = { previewer = "man_native" },
    helptags = { previewer = "help_native" },
    tags = { previewer = "bat" },
    btags = { previewer = "bat" },
})

Map('n', 'gd', function()
    require('fzf-lua').lsp_definitions({
        sync = true,
        jump_to_single_result = true,
    })
end)
Map('n', 'gD', function()
    require('fzf-lua').lsp_definitions({
        sync = true,
        jump_to_single_result = true,
        jump_to_single_result_action = require('fzf-lua.actions').file_vsplit,
    })
end)
Map('n', 'gr', function()
    require('fzf-lua').lsp_references({
        sync = true,
        jump_to_single_result = true,
    })
end)
Map('n', 'gdx', function()
    require('fzf-lua').lsp_definitions({
        sync = true,
        jump_to_single_result = true,
        jump_to_single_result_action = require('fzf-lua.actions').file_split,
    })
end)
Map('n', 'gdt', function()
    require('fzf-lua').lsp_definitions({
        sync = true,
        jump_to_single_result = true,
        jump_to_single_result_action = require('fzf-lua.actions').file_tabedit,
    })
end)
