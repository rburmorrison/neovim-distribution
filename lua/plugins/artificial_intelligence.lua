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
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>",     desc = "Invoke CodeCompanion Actions", mode = "v", },
    },
    opts = {
      strategies = {
        inline = { adapter = "openai", },
        chat = {
          adapter = "openai",
          slash_commands = {
            ["buffer"] = { opts = { provider = "telescope", }, },
            ["file"] = { opts = { provider = "telescope", }, },
            ["help"] = { opts = { provider = "telescope", }, },
            ["symbols"] = { opts = { provider = "telescope", }, },
          },
        },
        agent = { adapter = "openai", },
        cmd = { adapter = "openai", },
      },
      display = {
        action_palette = {
          provider = "telescope",
        },
        diff = {
          layout = "horizontal",
        },
      },
    },
  },
}
