if vim.g.vscode then
  local vscode = require("vscode")

  -------------------------
  -- Copilot Keybindings --
  -------------------------

  vim.keymap.set({ "n", "v", }, "<leader>pi", function()
    vscode.call("inlineChat.start")
  end, { desc = "Inline Edit", })

  vim.keymap.set("n", "<leader>po", function()
    vscode.call("workbench.action.chat.openEditSession")
  end, { desc = "Open Chat Edit Session", })

  ---------------------------------
  -- Language Server Keybindings --
  ---------------------------------

  vim.keymap.set("n", "<leader>ls", function()
    vscode.call("workbench.action.gotoSymbol")
  end, { desc = "Document Symbols", })

  vim.keymap.set("n", "<leader>lS", function()
    vscode.call("workbench.action.showAllSymbols")
  end, { desc = "Workspace Symbols", })

  vim.keymap.set("n", "<leader>li", function()
    vscode.call("editor.action.goToImplementation")
  end, { desc = "Implementations", })

  vim.keymap.set("n", "<leader>lR", function()
    vscode.call("editor.action.referenceSearch.trigger")
  end, { desc = "References", })

  vim.keymap.set("n", "<leader>la", function()
    vscode.call("editor.action.quickFix")
  end, { desc = "Code Action", })

  vim.keymap.set("n", "<leader>lr", function()
    vscode.call("editor.action.rename")
  end, { desc = "Rename", })

  vim.keymap.set("n", "<leader>lf", function()
    vscode.call("editor.action.formatDocument")
  end, { desc = "Format", })

  vim.keymap.set("n", "<leader>ld", function()
    vscode.call("workbench.action.problems.focus")
  end, { desc = "Document Diagnostics", })

  vim.keymap.set("n", "<leader>lD", function()
    vscode.call("workbench.action.problems.focus")
  end, { desc = "Workspace Diagnostics", })
else
  -------------------------
  -- General Keybindings --
  -------------------------

  vim.keymap.set("n", "<leader>L", "<cmd>set number!<cr>", { desc = "Toggle Line Numbers", })

  ---------------------------------
  -- Language Server Keybindings --
  ---------------------------------

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ctx)
      ----------------------------
      -- Document Symbol Picker --
      ----------------------------
      vim.keymap.set(
        "n",
        "<leader>ls",
        function() MiniExtra.pickers.lsp({ scope = "document_symbol", }) end,
        { buffer = ctx.buf, desc = "Document Symbols", }
      )

      ---------------------------
      -- Workspace Symbol List --
      ---------------------------
      vim.keymap.set(
        "n",
        "<leader>lS",
        function() MiniExtra.pickers.lsp({ scope = "workspace_symbol", }) end,
        { buffer = ctx.buf, desc = "Workspace Symbols", }
      )

      ---------------------------
      -- Implementation Finder --
      ---------------------------
      vim.keymap.set(
        "n",
        "<leader>li",
        function() MiniExtra.pickers.lsp({ scope = "implementation", }) end,
        { buffer = ctx.buf, desc = "Implementations", }
      )

      -----------------------
      -- References Finder --
      -----------------------
      vim.keymap.set(
        "n",
        "<leader>lR",
        function() MiniExtra.pickers.lsp({ scope = "references", }) end,
        { buffer = ctx.buf, desc = "References", }
      )

      -------------------------
      -- Code Action Trigger --
      -------------------------
      vim.keymap.set(
        "n",
        "<leader>la",
        vim.lsp.buf.code_action,
        { buffer = ctx.buf, desc = "Code Action", }
      )

      -------------------
      -- Symbol Rename --
      -------------------
      vim.keymap.set(
        "n",
        "<leader>lr",
        vim.lsp.buf.rename,
        { buffer = ctx.buf, desc = "Rename", }
      )

      --------------------
      -- Code Formatter --
      --------------------
      vim.keymap.set(
        "n",
        "<leader>lf",
        vim.lsp.buf.format,
        { buffer = ctx.buf, desc = "Format", }
      )

      --------------------------
      -- Document Diagnostics --
      --------------------------
      vim.keymap.set(
        "n",
        "<leader>ld",
        function() MiniExtra.pickers.diagnostic({ scope = "current", }) end,
        { buffer = ctx.buf, desc = "Document Diagnostics", }
      )

      ---------------------------
      -- Workspace Diagnostics --
      ---------------------------
      vim.keymap.set(
        "n",
        "<leader>lD",
        function() MiniExtra.pickers.diagnostic({ scope = "all", }) end,
        { buffer = ctx.buf, desc = "Workspace Diagnostics", }
      )
    end,
  })
end
