return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
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
    version = "^v0.9",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "clojure",
          "cpp",
          "gitignore",
          "go",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "proto",
          "python",
          "regex",
          "ruby",
          "rust",
          "sql",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = "i" },
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = "n" },
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = "t" },
    },
    version = "*",
    config = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },
}
