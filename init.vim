" ------------------- "
" -- User Settings -- "
" ------------------- "
let mapleader = " "
let maplocalleader = ","
let enable_crates_nvim = 1

" Basic Settings {{{
set number
set undofile

if has("nvim")
    " Treesitter folding for NeoVim.
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set nofoldenable
elseif !has("nvim")
    " Many of these come from NeoVim's defaults, which can be found at
    " ":help vim_diff.txt" in NeoVim. 

    set autoindent
    set modeline
    set mouse=nvi
    set smarttab
    set termguicolors
    set wildmenu

    filetype plugin indent on
    syntax enable
endif
" }}}

" NeoVim Plugins Setup {{{
if has("nvim")
lua << EOF
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
EOF
endif
" }}}

" File Type-Specific Settings {{{
augroup CustomFileTypeSettings
    autocmd!

    " Reasonable Defaults
    autocmd FileType *
                \ setlocal colorcolumn=81,121 |
                \ setlocal expandtab          |
                \ setlocal shiftwidth=2       |
                \ setlocal tabstop=2          |
                \ setlocal textwidth=80       |

    " Language-specific settings are defined below. This is done with autocmd in
    " order to avoid some complications that occur when sourcing the NeoVim
    " configuration from `~/.vimrc`, as well as to avoid repeating files in the
    " `ftplugin` directory.
    "
    " Languages accounted for: (aligned with autocmd calls below)
    "                c,cpp,rust,go,bash,javascript,typescript,python,ruby,sql,vim,lua,json,toml,yaml,markdown,gitcommit

    " Spell-Checked Files
    autocmd FileType c,cpp,rust,go,bash,javascript,typescript,python,ruby,sql,vim,lua,json,toml,yaml,markdown,gitcommit
                \ setlocal spell

    " Four-Width Indent Files
    autocmd FileType c,cpp,rust,go,bash,python,sql,vim
                \ setlocal shiftwidth=4 |
                \ setlocal tabstop=4    |
augroup END
" }}}

" vim:set nowrap:
" vim:set foldenable:
" vim:set foldmethod=marker:
