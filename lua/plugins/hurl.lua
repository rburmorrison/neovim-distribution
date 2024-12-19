return {
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    keys = {
      { "<leader>hR", "<cmd>HurlRunner<cr>",        desc = "Run all requests",             ft = "hurl", },
      { "<leader>hr", "<cmd>HurlRunnerAt<cr>",      desc = "Run current request",          ft = "hurl", },
      { "<leader>hA", "<cmd>HurlRunnerToEntry<cr>", desc = "Run requests above",           ft = "hurl", },
      { "<leader>hB", "<cmd>HurlRunnerToEnd<cr>",   desc = "Run requests below",           ft = "hurl", },
      { "<leader>hm", "<cmd>HurlToggleMode<cr>",    desc = "Toggle Hurl output mode",      ft = "hurl", },
      { "<leader>hv", "<cmd>HurlVerbose<cr>",       desc = "Run request in verbose mode",  ft = "hurl", },
      { "<leader>hV", "<cmd>HurlVeryVerbose<cr>",   desc = "Run API in very verbose mode", ft = "hurl", },
      { "<leader>hr", ":HurlRunner<cr>",            desc = "Run Selected Requests",        ft = "hurl", mode = "v", },
    },
    opts = {
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
    },
  },
}
