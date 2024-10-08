return {
  "tpope/vim-surround",
  "tpope/vim-commentary",

  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", },
    keys = {
      { "<leader>ss", "<cmd>GrugFar<cr>", desc = "Grug Far", },
    },
    opts = {
      startInInsertMode = false,
    },
  },

  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", "<cmd>lua require('neogit').open()<cr>", desc = "Neogit", },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },

  {
    "gbprod/substitute.nvim",
    keys = {
      { "s",  "<cmd>lua require('substitute').operator()<cr>", },
      { "ss", "<cmd>lua require('substitute').line()<cr>", },
      { "S",  "<cmd>lua require('substitute').eol()<cr>", },
      { "s",  "<cmd>lua require('substitute').visual()<cr>",   mode = "x", },
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
      { "<leader>oo", "<cmd>lua require('oil').toggle_float()<cr>", desc = "Open Oil", },
    },
  },
}
