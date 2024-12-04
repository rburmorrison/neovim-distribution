return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    keys = {
      { "<leader>ci", "<cmd>CodeCompanion<cr>",            desc = "CodeCompanion Inline Edit", },
      { "<leader>ci", "<cmd>CodeCompanion<cr>",            desc = "CodeCompanion Inline Edit",    mode = "v", },
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion Chat", },
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>",     desc = "Invoke CodeCompanion Actions", },
    },
    opts = {
      strategies = {
        inline = { adapter = "anthropic", },
        chat = { adapter = "anthropic", },
        agent = { adapter = "anthropic", },
        cmd = { adapter = "anthropic", },
      },
      display = {
        action_palette = {
          provider = "telescope",
        },
      },
    },
  },
}
