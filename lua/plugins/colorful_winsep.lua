if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinLeave", },
    opts = {},
  },
}
