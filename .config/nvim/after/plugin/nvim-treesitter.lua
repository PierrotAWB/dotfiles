require 'nvim-ts-autotag'.setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "rust", "html", "css", "tsx" },
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    autotag = {
        enable = true,
    },
    indent = {
        enable = true,
    }
})
