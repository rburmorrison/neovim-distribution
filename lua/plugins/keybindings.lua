return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false, })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")

      wk.add({
        { "<leader>L", "<cmd>set number!<cr>", desc = "Toggle Line Numbers", },
        { "<leader>o", group = "open", },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function()
          wk.add({
            {
              { "<leader>l", group = "lsp", },
              {
                "<leader>ls",
                "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
                desc = "Document Symbols",
              },
              {
                "<leader>lS",
                "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>",
                desc = "Workspace Symbols",
              },
              {
                "<leader>li",
                "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",
                desc = "Implementations",
              },
              {
                "<leader>lR",
                "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
                desc = "References",
              },
              {
                "<leader>la",
                "<cmd>lua require('actions-preview').code_actions()<cr>",
                desc = "Code Action",
              },
              {
                "<leader>lr",
                "<cmd>lua vim.lsp.buf.rename()<cr>",
                desc = "Rename",
              },
              {
                "<leader>lf",
                "<cmd>lua vim.lsp.buf.format()<cr>",
                desc = "Format",
              },
              {
                "<leader>ld",
                "<cmd>Trouble diagnostics open focus=true filter.buf=0<cr>",
                desc = "Document Diagnostics",
              },
              {
                "<leader>lD",
                "<cmd>Trouble diagnostics open focus=true<cr>",
                desc = "Workspace Diagnostics",
              },
            },
          })
        end,
      })
    end,
  },
}
