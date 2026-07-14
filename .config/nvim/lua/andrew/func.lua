local M = {}

function M.toggle_diagnostics()
    local config = vim.diagnostic.config()
    vim.diagnostic.config({
        virtual_text = not config.virtual_text,
        underline = not config.underline,
    })
end

return M
