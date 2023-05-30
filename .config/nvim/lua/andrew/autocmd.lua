-- Groups
local function au(group_name)
    vim.api.nvim_create_augroup(group_name, { clear = true })
end

local ft_group = au("ftGroup")
local save_group = au("SaveGroup")


-- Callbacks
local setJSTabbing = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
end


-- Autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
    command = "silent! lua vim.lsp.buf.format()",
    group = save_group,
})


vim.api.nvim_create_autocmd("BufEnter", {
    callback = setJSTabbing,
    group = ft_group,
    pattern = { "*.js", "*.ts" }
})
