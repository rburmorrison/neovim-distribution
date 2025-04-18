if vim.g.vscode then
  return {}
end

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", },
    ft = { "markdown", "Avante", },
    opts = {},
  },
}
