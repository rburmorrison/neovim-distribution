return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    config = function ()
      local wk = require("which-key")

      wk.add({
        { "<leader>f",  group = "find", },
        { "<leader>o",  group = "open", },
      })
    end
  },
}
