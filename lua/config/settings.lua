---------------------
-- Default Options --
---------------------

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-----------------------
-- FileType Settings --
-----------------------

local html_settings_patterns = {
  "*.html",
  "*.j2",
  "*.jinja",
  "*.jinja2",
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", }, {
  pattern = table.concat(html_settings_patterns, ","),
  group = vim.api.nvim_create_augroup("HTMLSettings", {}),
  callback = function()
    vim.opt_local.ft = "htmldjango"
  end,
})

local visual_settings_patterns = {
  "css",
  "dockerfile",
  "gitignore",
  "html",
  "htmldjango",
  "http",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "python",
  "rust",
  "sass",
  "scss",
  "sh",
  "toml",
  "typescript",
  "yaml",
  "zsh",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = table.concat(visual_settings_patterns, ","),
  group = vim.api.nvim_create_augroup("VisualSettings", {}),
  callback = function()
    vim.opt_local.colorcolumn = "81,121"
  end,
})

local spell_checked_settings_patterns = {
  "html",
  "htmldjango",
  "markdown",
  "typst",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = table.concat(spell_checked_settings_patterns, ","),
  group = vim.api.nvim_create_augroup("SpellCheckedSettings", {}),
  callback = function()
    vim.opt_local.spell = true
  end,
})

local large_indent_settings_languages = {
  "c",
  "cpp",
  "fish",
  "just",
  "python",
  "rust",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = table.concat(large_indent_settings_languages, ","),
  group = vim.api.nvim_create_augroup("LargeIndentSettings", {}),
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

local real_tab_settings_patterns = {
  "make",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = table.concat(real_tab_settings_patterns, ","),
  group = vim.api.nvim_create_augroup("RealTabSettings", {}),
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

local text_width_settings_patterns = {
  "markdown",
  "rust",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = table.concat(text_width_settings_patterns, ","),
  group = vim.api.nvim_create_augroup("TextWidthSettings", {}),
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local", })
  end,
})
