return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.align").setup()
      require("mini.pairs").setup()
      require("mini.comment").setup()
    end,
  },
}
