return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      gitsigns = true,
      beacon = true,
      noice = true,
      mason = true,
      lsp_trouble = true,
      which_key = true,
    },
    config = function()
      vim.cmd [[colorscheme catppuccin]]
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
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
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    config = function()
      local startify = require("alpha.themes.startify")
      startify.file_icons.provider = "devicons"
      require("alpha").setup(startify.config)
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
        "gitignore",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "json",
        "lua",
        "markdown",
        "proto",
        "python",
        "regex",
        "rust",
        "scss",
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
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = "i", desc = "Toggle floating terminal", },
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = "n", desc = "Toggle floating terminal", },
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = "t", desc = "Toggle floating terminal", },
    },
    opts = {},
  },
}
