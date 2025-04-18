if vim.g.vscode then
  return {}
end

return {
  {
    "rasulomaroff/reactive.nvim",
    opts = {
      load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline", },
      builtin = {
        cursorline = true,
        cursor = true,
        modemsg = true,
      },
    },
  },
}
