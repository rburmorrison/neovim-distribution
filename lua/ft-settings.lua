vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop    = 4
  end
})
