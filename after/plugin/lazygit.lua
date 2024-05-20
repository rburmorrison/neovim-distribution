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
      vim.api.nvim_buf_set_keymap(term.bufnr, "i", "<C-g>", "<cmd>close<CR>", { noremap = true, silent = true, })
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-g>", "<cmd>close<CR>", { noremap = true, silent = true, })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-g>", "<cmd>close<CR>", { noremap = true, silent = true, })
    end,
  })

  function _lazygit_toggle()
    lazygit:toggle()
  end

  vim.keymap.set("i", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>")
  vim.keymap.set("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>")
  vim.keymap.set("t", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>")
end
