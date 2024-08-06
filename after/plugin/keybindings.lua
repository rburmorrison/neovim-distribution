local wk = require("which-key")

-- LSP Bindings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function()
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

    wk.add({
      { "<leader>l",  group = "lsp", },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols theme=dropdown<cr>",    desc = "Document Symbols", },
      { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols theme=dropdown<cr>",   desc = "Workspace Symbols", },
      { "<leader>li", "<cmd>Telescope lsp_implementations theme=dropdown<cr>",     desc = "Implementations", },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                         desc = "Rename", },
      { "<leader>la", "<cmd>lua require(\"actions-preview\").code_actions()<cr>",  desc = "Code Action", },
      { "<leader>lR", "<cmd>Telescope lsp_references theme=dropdown<cr>",          desc = "References", },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>",                         desc = "Format", },
      { "<leader>ld", "<cmd>Trouble diagnostics open focus=true filter.buf=0<cr>", desc = "Document Diagnostics", },
      { "<leader>lD", "<cmd>Trouble diagnostics open focus=true<cr>",              desc = "Workspace Diagnostics", },
    })
  end,
})

-- crates.nvim Bindings
if vim.g.enable_crates_nvim == 1 then
  local crates = require("crates")

  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "Cargo.toml",
    callback = function(args)
      wk.add({
        buffer = args.buf,
        { "<leader>r",  group = "crates", },
        { "<leader>rt", crates.toggle,                             desc = "Toggle", },
        { "<leader>rr", crates.reload,                             desc = "Reload", },
        { "<leader>rv", crates.show_versions_popup,                desc = "Show Versions", },
        { "<leader>rf", crates.show_features_popup,                desc = "Show Features", },
        { "<leader>rd", crates.show_dependencies_popup,            desc = "Show Dependencies", },
        { "<leader>re", crates.expand_plain_crate_to_inline_table, desc = "Expand Crate", },
        { "<leader>rE", crates.extract_crate_into_table,           desc = "Extract Crate", },
        { "<leader>ru", crates.update_crate,                       desc = "Update Crate", },
        { "<leader>ra", crates.update_all_crates,                  desc = "Update All Crates", },
        { "<leader>rU", crates.upgrade_crate,                      desc = "Upgrade Crate", },
        { "<leader>rA", crates.upgrade_all_crates,                 desc = "Upgrade All Crates", },
      })
    end,
  })
end

-- DAP Bindings
local dap = require("dap")

wk.add({
  { "<leader>d",   group = "debug", },
  { "<leader>db",  dap.toggle_breakpoint,                                       desc = "Toggle Breakpoint", },
  { "<leader>di",  "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>", desc = "Inspect", },
  { "<leader>dc",  dap.continue,                                                desc = "Continue", },
  { "<leader>dC",  dap.run_to_cursor,                                           desc = "Run To Cursor", },
  { "<leader>dI",  dap.step_into,                                               desc = "Step Into", },
  { "<leader>dn",  dap.step_over,                                               desc = "Step Over", },
  { "<leader>dO",  dap.step_out,                                                desc = "Step Out", },
  { "<leader>dr",  dap.restart,                                                 desc = "Restart", },
  { "<leader>dt",  dap.terminate,                                               desc = "Terminate", },
  { "<leader>dl",  dap.run_last,                                                desc = "Run Last", },
  { "<leader>du",  group = "ui", },
  { "<leader>duo", require("dapui").open,                                       desc = "Open", },
  { "<leader>duc", require("dapui").close,                                      desc = "Close", },
})

-- Group Definitions
wk.add({
  { "<leader>f",  group = "find", },
  { "<leader>o",  group = "open", },
})
