if vim.fn.executable("lazygit") == 1 then
  local Terminal = require("toggleterm.terminal").Terminal

  local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
      border = "double",
    },
    hidden = true,
    on_open = function(term)
      vim.cmd("startinsert!")

      local opts = { noremap = true, silent = true };
      vim.api.nvim_buf_set_keymap(term.bufnr, "i", "<C-g>", "<cmd>close<cr>", opts)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-g>", "<cmd>close<cr>", opts)
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-g>", "<cmd>close<cr>", opts)
    end,
  })

  function LazygitToggle()
    lazygit:toggle()
  end

  vim.keymap.set("i", "<C-g>", "<cmd>lua LazygitToggle()<cr>")
  vim.keymap.set("n", "<C-g>", "<cmd>lua LazygitToggle()<cr>")
  vim.keymap.set("t", "<C-g>", "<cmd>lua LazygitToggle()<cr>")
end
