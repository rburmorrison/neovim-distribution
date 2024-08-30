return {
  "tpope/vim-surround",
  "tpope/vim-commentary",

  {
    "echasnovski/mini.align",
    version = "*",
    opts = {},
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = {
      { "echasnovski/mini.icons", opts = {}, },
    },
    keys = {
      { "<leader>oo", "<cmd>lua require('oil').toggle_float()<cr>", mode = "n", desc = "Open Oil", },
    },
  },
}
