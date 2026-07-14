-- Native LSP setup using vim.lsp.config/vim.lsp.enable (Neovim 0.11+).
-- Replaces lsp-zero, which relied on the deprecated require('lspconfig') framework.

-- Puts Mason-installed servers (e.g. tsgo) on PATH.
require('mason').setup()

-- Buffer-local keymaps for any attached server (same set lsp-zero provided).
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
    callback = function(event)
        local function map(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf })
        end

        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gD', function()
            vim.cmd.vsplit()
            vim.lsp.buf.definition()
        end)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', 'go', vim.lsp.buf.type_definition)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', 'gs', vim.lsp.buf.signature_help)
        map('n', '<F2>', vim.lsp.buf.rename)
        map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
        map('n', '<F4>', vim.lsp.buf.code_action)
        map('n', 'gl', vim.diagnostic.open_float)
    end,
})

-- Advertise nvim-cmp's completion capabilities to every server.
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Configure lua language server for neovim
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config('tsgo', {
    on_attach = function(client, bufnr)
        -- Set up formatting-on-save only if the server supports formatting.
        local supports_format = client.supports_method
                and client:supports_method('textDocument/formatting')
            or client.server_capabilities.documentFormattingProvider

        if supports_format then
            local group = vim.api.nvim_create_augroup('LspFormat', { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, async = false })
                end,
            })
        end
    end,
})

vim.lsp.enable({ 'lua_ls', 'tsgo' })
