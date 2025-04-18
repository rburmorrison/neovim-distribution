if vim.g.vscode then
  return {}
end

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.nvim",
    },
    keys = {
      { "<leader>gg", function() require("neogit").open() end, desc = "Neogit", },
    },
    opts = {
      mappings = {
        popup = {
          ["d"] = false, -- the inline diffs are good enough
        },
      },
    },
  },
}
