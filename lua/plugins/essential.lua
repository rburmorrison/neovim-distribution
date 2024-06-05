return {
  {
    "phaazon/hop.nvim",
    version = "v2",
    config = true,
  },

  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim", },
    setup = function()
      require("spectre").setup()
    end,
  },
}
