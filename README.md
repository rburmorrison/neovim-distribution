# Vim/Neovim Configuration

**Note:** Last tested with Neovim v0.11.1.

## Overview

This is my personal Neovim configuration, designed for a modern, productive development experience. It is built around the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager and includes a curated set of plugins for LSP, completion, UI, and workflow enhancements.

- **LSP Management:** Uses [Mason](https://github.com/williamboman/mason.nvim) for automatic installation and management of language servers. On first run, Mason will install a set of LSP servers (see below). The `fish_lsp` server is not managed by Mason and must be installed manually.
- **Completion:** Powered by [blink.cmp](https://github.com/saghen/blink.cmp) and [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) for fast, context-aware completion.
- **UI/UX:** Features the [catppuccin](https://github.com/catppuccin/nvim) theme, [colorful-winsep](https://github.com/nvim-zh/colorful-winsep.nvim) for window borders, and [reactive.nvim](https://github.com/rasulomaroff/reactive.nvim) for dynamic highlights.
- **Editing:** Includes [mini.nvim](https://github.com/echasnovski/mini.nvim) suite (see below), [emmet](https://github.com/olrtg/nvim-emmet) for HTML/CSS, and [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) for Markdown preview.
- **Git:** [Neogit](https://github.com/NeogitOrg/neogit) for a Magit-like Git interface.
- **Treesitter:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for fast, accurate syntax highlighting and code navigation.
- **Other:** [rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim), [luvit-meta](https://github.com/Bilal2453/luvit-meta), and more.

### Mason LSP Servers (auto-installed)
- basedpyright
- bashls
- biome
- cssls
- emmet_language_server
- html
- jsonls
- lua_ls
- marksman
- ruff
- rust_analyzer
- taplo
- ts_ls

**Note:** `fish_lsp` is enabled by default but must be installed manually (not managed by Mason).

### Notable Plugins
- **catppuccin:** Beautiful theme with integrations for many plugins.
- **blink.cmp:** Fast, extensible completion engine.
- **mini.nvim:** Modular suite for editing, navigation, commenting, and more.
- **nvim-treesitter:** Syntax highlighting and code intelligence.
- **neogit:** Git integration with a modern UI.
- **emmet:** HTML/CSS abbreviation expansion.
- **render-markdown:** Markdown preview and rendering.
- **colorful-winsep:** Colorful window separators.
- **rainbow-delimiters:** Rainbow parentheses and delimiters.
- **reactive.nvim:** Dynamic cursor and UI highlights.
- **luvit-meta:** Lua type metadata for better completion.
- **lazydev.nvim:** Lua development tools and library support.
- **rustaceanvim:** Rust LSP and tools integration.

## Installing

To install, run the following command (HTTPS):

```fish
git clone https://github.com/rburmorrison/neovim-distribution.git ~/.config/nvim
```

Or this one (SSH):

```fish
git clone git@github.com:rburmorrison/neovim-distribution.git ~/.config/nvim
```

After cloning, launch Neovim and plugins will be installed automatically. For `fish_lsp`, follow the [official instructions](https://github.com/ndonfris/fish-lsp) to install it on your system.

## VSCode Neovim Compatibility

This configuration is also designed to work with the [VSCode Neovim extension](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim). When used inside VSCode with this extension, only a subset of plugins and features are enabled for maximum compatibility and performance.

**Enabled plugins in VSCode:**
- A minimal set from the [mini.nvim](https://github.com/echasnovski/mini.nvim) suite, including:
  - `mini.align`
  - `mini.comment`
  - `mini.move`
  - `mini.operators`
  - `mini.jump2d`
  - `mini.surround`
  - `mini.splitjoin`
  - `mini.ai` (with custom textobjects)
  - `mini.indentscope`

Other plugins and advanced UI features are only available when running in native Neovim. See `lua/plugins/mini.lua` for details on which modules are loaded in each environment.

---

For more details, see the `lua/plugins/` directory for individual plugin configs.
