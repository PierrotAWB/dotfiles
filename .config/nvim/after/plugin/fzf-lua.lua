-- Modified from max-perf
local actions = require 'fzf-lua.actions'
require('fzf-lua').setup({
    actions = {
        files = {
            ["ctrl-x"] = actions.file_split,
        },
        buffers = {
            ["ctrl-x"] = actions.buf_split,
        }
    },
    files = { fzf_opts = { ["--ansi"] = false } },
    fzf_opts = { ['--layout'] = 'reverse-list' },
    winopts = { preview = { default = "bat" } },
    manpages = { previewer = "man_native" },
    helptags = { previewer = "help_native" },
    tags = { previewer = "bat" },
    btags = { previewer = "bat" },
    global_git_icons = false,
    global_file_icons = false,
})
