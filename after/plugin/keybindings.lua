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

-- crates.nvim
local crates = require('crates')

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "Cargo.toml",
  callback = function(args)
    wk.register({
      r = {
        name = "crates",
        t = { crates.toggle, "Toggle" },
        r = { crates.reload, "Reload" },
        v = { crates.show_versions_popup, "Show Versions" },
        f = { crates.show_features_popup, "Show Features" },
        d = { crates.show_dependencies_popup, "Show Dependencies" },
        e = { crates.expand_plain_crate_to_inline_table, "Expand Crate" },
        E = { crates.extract_crate_into_table, "Extract Crate" },
        u = { crates.update_crate,  "Update Crate" },
        a = { crates.update_all_crates, "Update All Crates" },
        U = { crates.upgrade_crate, "Upgrade Crate" },
        A = { crates.upgrade_all_crates, "Upgrade All Crates" },
      },
    }, { prefix = "<leader>", bufnr = args.bufnr })
  end,
})

-- GitHub Copilot
if vim.g.enable_github_copilot == 1 then
  wk.register({
    c = {
      name = "copilot",
      e = { "<cmd>Copilot enable<cr><cmd>Copilot status<cr>", "Enable" },
      d = { "<cmd>Copilot disable<cr><cmd>Copilot status<cr>", "Disable" },
      p = { "<cmd>Copilot panel<cr>", "Panel" },
      s = { "<cmd>Copilot status<cr>", "Status" },
    }
  }, { prefix = "<leader>" })
end