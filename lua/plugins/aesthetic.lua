return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      gitsigns = true,
      beacon = true,
      barbar = true,
      colorful_winsep = { enabled = true, color = "yellow", },
      fidget = true,
      mason = true,
      lsp_trouble = true,
      which_key = true,
    },
    config = function()
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
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave", },
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
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>cc", "<cmd>CccConvert<cr>", mode = "n", desc = "Color Convert", },
      { "<leader>cp", "<cmd>CccPick<cr>",    mode = "n", desc = "Color Picker", },
    },
    lazy = false,
    version = "*",
    config = function()
      local ccc = require("ccc")
      local output = ccc.output
      local picker = ccc.picker

      require("ccc").setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        convert = {
          { picker.hex,     output.css_rgb, },
          { picker.css_rgb, output.hex, },
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    opts = {
      options = { theme = "catppuccin", },
    },
  },

  {
    "j-hui/fidget.nvim",
    version = "*",
    opts = {},
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
        "javascript",
        "json",
        "lua",
        "markdown",
        "proto",
        "python",
        "regex",
        "rust",
        "sql",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enabled = true,
        additional_vim_regex_highlighting = true,
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()

      -- ToggleTerm keybindings
      vim.keymap.set("i", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal", })
      vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal", })
      vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal", })

      if vim.fn.executable("lazygit") == 1 then
        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit = Terminal:new({
          cmd = "lazygit",
          direction = "float",
          float_opts = {
            border = "double",
          },
          hidden = true,
          on_open = function(term)
            vim.cmd("startinsert!")

            local opts = { noremap = true, silent = true, }
            vim.api.nvim_buf_set_keymap(term.bufnr, "i", "<C-g>", "<cmd>close<cr>", opts)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-g>", "<cmd>close<cr>", opts)
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-g>", "<cmd>close<cr>", opts)
          end,
        })

        local function lazygit_toggle()
          lazygit:toggle()
        end

        -- Lazygit keybindings
        vim.keymap.set("i", "<C-g>", lazygit_toggle, { desc = "Toggle Lazygit", })
        vim.keymap.set("n", "<C-g>", lazygit_toggle, { desc = "Toggle Lazygit", })
        vim.keymap.set("t", "<C-g>", lazygit_toggle, { desc = "Toggle Lazygit", })
      end
    end,
  },
}
