if vim.g.vscode then
  return {}
end

return {
  {
    "olrtg/nvim-emmet",
    ft = { "html", "htmldjango", },
    keys = {
      {
        "<leader>xe",
        function() require("nvim-emmet").wrap_with_abbreviation() end,
        desc = "Expand Emmet Expression",
        mode = { "n", "v", },
        ft = { "html", "htmldjango", },
      },
    },
    config = false,
  },
}
