vim.api.nvim_create_user_command("Ansi", function(opts)
  local line1 = opts.line1
  local line2 = opts.line2

  vim.cmd(string.format(
    [[%d,%ds/\%%x1b\[[0-9;?]*[ -/]*[@-~]//g]],
    line1,
    line2
  ))
end, { range = "%" })

vim.cmd([[cnoreabbrev ansi Ansi]])
