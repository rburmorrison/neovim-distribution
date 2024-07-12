return {
  { "tpope/vim-surround", },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim", },
    setup = function()
      require("spectre").setup()
    end,
  },
}
