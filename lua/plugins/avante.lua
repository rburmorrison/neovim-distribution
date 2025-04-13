return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.nvim",
      {
        "stevearc/dressing.nvim",
        opts = {
          select = { enabled = false, },
          input = { enabled = false, },
        },
      },
    },
    build = "make",
    opts = {
      provider = "openrouter_provider",
      cursor_applying_provider = "openrouter_cursor_applying_provider",
      behaviour = { enable_cursor_planning_mode = true, },
      vendors = {
        openrouter_provider = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "google/gemini-2.5-pro-preview-03-25",
        },
        openrouter_cursor_applying_provider = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "google/gemini-2.0-flash-001",
        },
      },
      file_selector = { provider = "mini.pick", },
    },
  },
}
