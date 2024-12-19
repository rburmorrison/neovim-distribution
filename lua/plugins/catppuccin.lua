return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          blink_cmp = true,
          cmp = true,
          colorful_winsep = { enabled = true, color = "mauve", },
          mason = true,
          neotest = true,
          rainbow_delimiters = true,
          render_markdown = true,
          snacks = true,
        },
      })

      vim.cmd("colorscheme catppuccin")
    end,
  },

}
