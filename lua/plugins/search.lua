return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fb", "<cmd>Telescope buffers theme=dropdown<cr>",    desc = "Buffers", },
      { "<leader>ff", "<cmd>Telescope find_files theme=dropdown<cr>", desc = "Find Files", },
      { "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<cr>",  desc = "Live Grep", },
      { "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<cr>",  desc = "Help Tags", },
    },
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim", },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = actions.close,
            },
          },
        },
      })
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    opts = {
      backend = { "telescope", },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>ot", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" }
    },
    dependencies = { "nvim-tree/nvim-web-devicons", },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Close the buffer when it's the last one.
      --
      -- This works by checking if it's the last window when the buffer is
      -- entered, which will occur when all other windows are closed.
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
          end
        end,
      })

      require("nvim-tree").setup({ view = { width = 30, }, })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    config = true,
  },
}
