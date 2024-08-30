return {
  {
    "aznhe21/actions-preview.nvim",
    opts = {
      backend = { "telescope", },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    opts = {},
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", },
    tag = "0.1.8",
    keys = {
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", mode = "n", desc = "Find Files", },
      { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>",  mode = "n", desc = "Live Grep", },
      { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",    mode = "n", desc = "Buffers", },
      { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",  mode = "n", desc = "Help Tags", },
    },
  },
}
