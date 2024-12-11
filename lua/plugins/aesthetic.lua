return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          beacon = true,
          cmp = true,
          colorful_winsep = { enabled = true, color = "mauve", },
          gitsigns = true,
          lsp_trouble = true,
          mason = true,
          neotest = true,
          rainbow_delimiters = true,
          render_markdown = true,
          snacks = true,
          which_key = true,
        },
      })

      vim.cmd [[colorscheme catppuccin]]
    end,
  },

  { "danilamihailov/beacon.nvim", },

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
    "hedyhli/outline.nvim",
    config = function()
      require("outline").setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("OutlineNvim", {}),
        callback = function()
          require("which-key").add({
            { "<leader>lo", "<cmd>Outline<cr>", buffer = true, desc = "Toggle Outline", },
          })
        end,
      })
    end,
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
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      virtual_symbol = "",
      virtual_symbol_position = "eol",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/noice.nvim",
    },
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin", },
        sections = {
          lualine_c = {
            {
              -- These lints are disabled since the key config is pulled from
              -- Noice itself.

              ---@diagnostic disable-next-line: undefined-field
              require("noice").api.status.command.get,
              ---@diagnostic disable-next-line: undefined-field
              cond = require("noice").api.status.command.has,
              color = { fg = "#f9e2af", },
            },
          },
          lualine_x = {
            "encoding",
            "fileformat",
            "filetype",
            "filename",
          },
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    verison = "*",
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
