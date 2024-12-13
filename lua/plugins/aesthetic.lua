return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
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

  { "HiPhish/rainbow-delimiters.nvim", },

  {
    "rasulomaroff/reactive.nvim",
    opts = {
      load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline", },
      builtin = {
        cursorline = true,
        cursor = true,
        modemsg = true,
      },
    },
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinLeave", },
    opts = {},
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", },
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "htmldjango",
        "hurl",
        "javascript",
        "json",
        "just",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "proto",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    },
  },
}
