return {
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha"
      })

      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    main = "colorizer",
    opts = {
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "html"
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 30
        }
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close
            }
          }
        }
      })
    end
  },
  {
    "aznhe21/actions-preview.nvim",
    opts = {
      backend = { "telescope" },
    }
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
  },
  {
    "lewis6991/gitsigns.nvim",
    config = true
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true
  },
  {
    "numToStr/Comment.nvim",
    config = true
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
  }
}
