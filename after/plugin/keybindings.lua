local wk = require("which-key")

-- LSP Bindings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function()
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

    wk.register({
      g = {
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
      }
    })

    wk.register({
      l = {
        name = "lsp",
        s = { "<cmd>Telescope lsp_document_symbols theme=dropdown<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_workspace_symbols theme=dropdown<cr>", "Workspace Symbols" },
        i = { "<cmd>Telescope lsp_implementations theme=dropdown<cr>", "Implementations" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        a = { "<cmd>lua require(\"actions-preview\").code_actions()<cr>", "Code Action" },
        R = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "References" },
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
        D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      },
    }, { prefix = "<leader>" })
  end
})
