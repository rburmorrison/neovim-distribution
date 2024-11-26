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

  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "hurl",
        group = vim.api.nvim_create_augroup("VisualSettings", {}),
        callback = function()
          require("hurl").setup({
            debug = false,
            show_notification = false,
            mode = "popup",
            formatters = {
              json = { "jq", }, -- Make sure you have install jq in your system, e.g: brew install jq
            },
            mappings = {
              close = "q",          -- Close the response popup or split view
              next_panel = "<C-n>", -- Move to the next response popup window
              prev_panel = "<C-p>", -- Move to the previous response popup window
            },
          })

          require("which-key").add({
            { "<leader>hR", "<cmd>HurlRunner<CR>",        buffer = true, desc = "Run all requests", },
            { "<leader>hr", "<cmd>HurlRunnerAt<CR>",      buffer = true, desc = "Run current request", },
            { "<leader>hA", "<cmd>HurlRunnerToEntry<CR>", buffer = true, desc = "Run requests above", },
            { "<leader>hB", "<cmd>HurlRunnerToEnd<CR>",   buffer = true, desc = "Run requests below", },
            { "<leader>hm", "<cmd>HurlToggleMode<CR>",    buffer = true, desc = "Hurl Toggle Mode", },
            { "<leader>hv", "<cmd>HurlVerbose<CR>",       buffer = true, desc = "Run request in verbose mode", },
            { "<leader>hV", "<cmd>HurlVeryVerbose<CR>",   buffer = true, desc = "Run API in very verbose mode", },
            { "<leader>hr", ":HurlRunner<CR>",            buffer = true, desc = "Run Selected Requests",        mode = "v", },
          })
        end,
      })
    end,
  },
}
