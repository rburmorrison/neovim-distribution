return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    config = function()
      -- Terminal Toggle
      vim.keymap.set("i", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")
      vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")
      vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")

      local wk = require("which-key")

      -- Shared Bindings
      local hop_bindings = {
          name = "hop",
          w = { "<cmd>HopWord<cr>", "Word" },
          c = { "<cmd>HopChar1<cr>", "Character" },
          b = { "<cmd>HopChar2<cr>", "Bigram" },
          p = { "<cmd>HopPattern<cr>", "Bigram" },
          l = { "<cmd>HopLineStart<cr>", "Line" },
          a = { "<cmd>HopAnywhere<cr>", "Anywhere" },
          m = {
            name = "multi-window",
            w = { "<cmd>HopWordMW<cr>", "Word" },
            c = { "<cmd>HopChar1MW<cr>", "Character" },
            b = { "<cmd>HopChar2MW<cr>", "Bigram" },
            p = { "<cmd>HopPatternMW<cr>", "Bigram" },
            l = { "<cmd>HopLineStartMW<cr>", "Line" },
            a = { "<cmd>HopAnywhereMW<cr>", "Anywhere" },
          }
        }

      -- Normal Bindings
      wk.register({
        o = {
          name = "open",
          t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
        },
        f = {
          name = "find",
          f = { "<cmd>Telescope find_files theme=dropdown<cr>", "Find Files" },
          g = { "<cmd>Telescope live_grep theme=dropdown<cr>", "Live Grep" },
          b = { "<cmd>Telescope buffers theme=dropdown<cr>", "Buffers" },
          h = { "<cmd>Telescope help_tags theme=dropdown<cr>", "Help Tags" },
        },
        h = hop_bindings,
      }, { prefix = "<leader>" })

      -- Visual Bindings
      wk.register({
        h = hop_bindings,
      }, { prefix = "<leader>", mode = "v" })

      -- Misc Bindings
      wk.register({
        g = {
          l = { "$", "Goto line end" },
          s = { "^", "Goto first character" },
          h = { "0", "Goto line start" },
        }
      })
    end
  },
}
