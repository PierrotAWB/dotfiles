local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require'lspconfig'.tsserver.setup{
    on_attach = function(client, bufnr)
        -- other on_attach logic here

        -- Set up formatting capabilities, if the LSP server supports it
        if client.resolved_capabilities.document_formatting then
            vim.cmd [[augroup Format]]
            vim.cmd [[autocmd! * <buffer>]]
            vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
            vim.cmd [[augroup END]]
        end
    end
}

lsp.setup()

-- Make sure you setup `cmp` after lsp-zero
cmp.setup({
    mapping = {
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    }
})
