return {
  "tpope/vim-surround",
  "tpope/vim-commentary",

  {
    "NeogitOrg/neogit",
    keys = {
      { "<C-g>", "<cmd>lua require('neogit').open()<cr>", mode = "n", desc = "Neogit", },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },

  {
    "echasnovski/mini.align",
    version = "*",
    opts = {},
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    dependencies = {
      { "echasnovski/mini.icons", opts = {}, },
    },
    keys = {
      { "<leader>oo", "<cmd>lua require('oil').toggle_float()<cr>", mode = "n", desc = "Open Oil", },
    },
  },
}
