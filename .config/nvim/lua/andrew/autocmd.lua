-- Groups
local function au(group_name)
    vim.api.nvim_create_augroup(group_name, { clear = true })
end

local js_group = au("ftGroup")
local md_group = au("mdGroup")
local save_group = au("SaveGroup")
local highlight_yank = au("HighlightYank")


-- Autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end,
    group = save_group,
})


vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
    group = js_group,
    pattern = { "*.js", "*.ts" }
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt_local.textwidth = 60
    end,
    group = md_group,
    pattern = { "*.md" }
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
    end,
    group = highlight_yank,
})

-- Clear editor backgrounds so the terminal's own background shows through
local transparent_bg = au("TransparentBackground")
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        for _, group in ipairs({
            "Normal", "NormalNC", "NormalFloat", "FloatBorder",
            "SignColumn", "LineNr", "CursorLineNr", "EndOfBuffer",
            "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
        }) do
            local hl = vim.api.nvim_get_hl(0, { name = group })
            hl.bg = nil
            hl.ctermbg = nil
            vim.api.nvim_set_hl(0, group, hl)
        end
    end,
    group = transparent_bg,
})
