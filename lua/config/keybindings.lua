vim.keymap.set("n", "<leader>L", "<cmd>set number!<cr>", { desc = "Toggle Line Numbers", })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function()
    ----------------------------
    -- Document Symbol Picker --
    ----------------------------
    vim.keymap.set(
      "n",
      "<leader>ls",
      function() MiniExtra.pickers.lsp({ scope = "document_symbol", }) end,
      { buffer = true, desc = "Document Symbols", }
    )

    ---------------------------
    -- Workspace Symbol List --
    ---------------------------
    vim.keymap.set(
      "n",
      "<leader>lS",
      function() MiniExtra.pickers.lsp({ scope = "workspace_symbol", }) end,
      { buffer = true, desc = "Workspace Symbols", }
    )

    ---------------------------
    -- Implementation Finder --
    ---------------------------
    vim.keymap.set(
      "n",
      "<leader>li",
      function() MiniExtra.pickers.lsp({ scope = "implementation", }) end,
      { buffer = true, desc = "Implementations", }
    )

    -----------------------
    -- References Finder --
    -----------------------
    vim.keymap.set(
      "n",
      "<leader>lR",
      function() MiniExtra.pickers.lsp({ scope = "references", }) end,
      { buffer = true, desc = "References", }
    )

    -------------------------
    -- Code Action Trigger --
    -------------------------
    vim.keymap.set(
      "n",
      "<leader>la",
      vim.lsp.buf.code_action,
      { buffer = true, desc = "Code Action", }
    )

    -------------------
    -- Symbol Rename --
    -------------------
    vim.keymap.set(
      "n",
      "<leader>lr",
      vim.lsp.buf.rename,
      { buffer = true, desc = "Rename", }
    )

    --------------------
    -- Code Formatter --
    --------------------
    vim.keymap.set(
      "n",
      "<leader>lf",
      vim.lsp.buf.format,
      { buffer = true, desc = "Format", }
    )

    --------------------------
    -- Document Diagnostics --
    --------------------------
    vim.keymap.set(
      "n",
      "<leader>ld",
      function() MiniExtra.pickers.diagnostic({ scope = "current", }) end,
      { buffer = true, desc = "Document Diagnostics", }
    )

    ---------------------------
    -- Workspace Diagnostics --
    ---------------------------
    vim.keymap.set(
      "n",
      "<leader>lD",
      function() MiniExtra.pickers.diagnostic({ scope = "all", }) end,
      { buffer = true, desc = "Workspace Diagnostics", }
    )
  end,
})
