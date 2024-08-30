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
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function()
          require("which-key").add({
            { "<leader>o", group = "open", },
            {
              { "<leader>l",  group = "lsp", },
              {
                "<leader>ls",
                "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
                mode = "n",
                desc = "Document Symbols",
              },
              { "<leader>lS", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>",       mode = "n", desc = "Workspace Symbols", },
              { "<leader>li", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",         mode = "n", desc = "Implementations", },
              { "<leader>lR", "<cmd>lua require('telescope.builtin').lsp_references theme=dropdown<cr>", mode = "n", desc = "References", },
              { "<leader>la", "<cmd>lua require('actions-preview').code_actions()<cr>",                  mode = "n", desc = "Code Action", },
              { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                                       mode = "n", desc = "Rename", },
              { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>",                                       mode = "n", desc = "Format", },
              { "<leader>ld", "<cmd>Trouble diagnostics open focus=true filter.buf=0<cr>",               mode = "n", desc = "Document Diagnostics", },
              { "<leader>lD", "<cmd>Trouble diagnostics open focus=true<cr>",                            mode = "n", desc = "Workspace Diagnostics", },
            },
          })
        end,
      })
    end,
  },
}
