-------------
-- Globals --
-------------

vim.g.mapleader = " "
vim.g.maplocalleader = ","

---------------------
-- Default Options --
---------------------

vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 99

-----------------------
-- FileType Settings --
-----------------------

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", }, {
  pattern = "*.html,*.j2,*.jinja,*.jinja2",
  group = vim.api.nvim_create_augroup("HTMLSettings", {}),
  callback = function()
    vim.opt_local.ft = "htmldjango"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua,rust,sh,html,markdown,html,css,javascript,typescript",
  group = vim.api.nvim_create_augroup("VisualSettings", {}),
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.colorcolumn = "81,121"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown,html",
  group = vim.api.nvim_create_augroup("SpellCheckedSettings", {}),
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust,c,cpp",
  group = vim.api.nvim_create_augroup("LargeIndentSettings", {}),
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  group = vim.api.nvim_create_augroup("RealTabSettings", {}),
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust,markdown",
  group = vim.api.nvim_create_augroup("TextwidthSettings", {}),
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})
