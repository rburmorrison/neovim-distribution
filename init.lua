-- General Options

vim.g.mapleader = " "

vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop    = 2
vim.opt.expandtab  = true

vim.opt.undofile = true

-- Plugin Management

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
