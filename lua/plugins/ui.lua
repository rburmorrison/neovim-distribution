return {
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = true
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = "tokyonight"
      }
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Close the buffer when it's the last one.
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
          end
        end
      })

      require("nvim-tree").setup({
        view = {
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
