if vim.g.vscode then
  return {}
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv", }, },
      },
    },
  },
}
