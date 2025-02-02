local adapter = "anthropic"

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>pC", "<cmd>CodeCompanion /commit<cr>", desc = "CodeCompanion Commit",  mode = "n", },
      { "<leader>pa", "<cmd>CodeCompanionActions<cr>",  desc = "CodeCompanion Actions", mode = { "v", "n", }, },
      { "<leader>pc", "<cmd>CodeCompanionChat<cr>",     desc = "CodeCompanion Chat",    mode = "n", },
      { "<leader>pi", "<cmd>CodeCompanion<cr>",         desc = "CodeCompanion Inline",  mode = { "v", "n", }, },
      { "<leader>px", ":CodeCompanionCmd ",             desc = "CodeCompanion Cmd",     mode = "n", },
    },
    opts = {
      strategies = {
        chat = { adapter = adapter, },
        inline = { adapter = adapter, },
        cmd = { adapter = adapter, },
      },
      display = {
        diff = {
          provider = "mini_diff",
        },
      },
    },
  },
}
