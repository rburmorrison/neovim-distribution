return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[colorscheme tokyonight]]
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
