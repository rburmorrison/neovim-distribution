return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    -- Terminal Toggle
    vim.keymap.set("i", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { remap = true })
    vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { remap = true })
    vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { remap = true })

    local wk = require("which-key")

    -- Normal Bindings
    wk.register({
      o = {
        name = "open",
        t = { "<cmd>Neotree toggle<cr>", "Neo-tree" },
      },
      f = {
        name = "find",
        f = { "<cmd>Telescope find_files theme=dropdown<cr>", "Find Files" },
        g = { "<cmd>Telescope live_grep theme=dropdown<cr>", "Live Grep" },
        b = { "<cmd>Telescope buffers theme=dropdown<cr>", "Buffers" },
        h = { "<cmd>Telescope help_tags theme=dropdown<cr>", "Help Tags" },
      }
    }, { prefix = "<leader>" })

    -- LSP Bindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function()
        wk.register({
          l = {
            name = "lsp",
            K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation" },
            S = { "<cmd>Telescope lsp_workspace_symbols theme=dropdown<cr>", "Workspace Symbols" },
            s = { "<cmd>Telescope lsp_document_symbols theme=dropdown<cr>", "Document Symbols" },
            D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
            i = { "<cmd>Telescope lsp_implementations theme=dropdown<cr>", "Implementations" },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            R = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "References" },
            f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
            p = { "<cmd>Telescope diagnostics theme=dropdown<cr>", "Diagnostics" },
          },
        }, { prefix = "<leader>" })
      end
    })
  end
}
