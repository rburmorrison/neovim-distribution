return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },
  
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "rust",
          "go",
          "bash",
          "javascript",
          "typescript",
          "python",
          "ruby",
          "regex",
          "sql",
          "vim",
          "lua",
          "json",
          "toml",
          "yaml",
          "markdown",
          "gitignore",
          "proto",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      })
    end,
  },

  { "akinsho/toggleterm.nvim", version = "*", config = true },
  
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = true },

  { "lewis6991/gitsigns.nvim", config = true },
}
