return {
  "tpope/vim-surround",
  "tpope/vim-commentary",

  {
    "rest-nvim/rest.nvim",
    ft = { "http", },
    version = "*",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        group = vim.api.nvim_create_augroup("RestNvim", {}),
        callback = function()
          vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run", buffer = true, })
        end,
      })
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    lazy = false,
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
