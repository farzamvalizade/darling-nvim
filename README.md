# Darling.nvim

> My personal Neovim configuration — fast, minimal, and built for development.

![Darling.nvim](./assets/dashboard.png)

## Features

* ⚡ Fast startup with `vim.pack`
* 🧠 LSP + autocompletion
* 🌳 Treesitter
* 🔭 Telescope
* 📁 Neo-tree
* 🐙 Git integration
* 🎨 Custom dashboard & UI
* ✨ Formatting & diagnostics
* 📝 Snippets and autopairs
* 🧹 Automatic code formatting

## Keymaps

### General

| Key          | Action                  |
| ------------ | ----------------------- |
| `Ctrl + S`   | Save                    |
| `Ctrl + Q`   | Quit                    |
| `Space + W`  | Save                    |
| `Space + Q`  | Quit                    |
| `Space + SN` | Save without formatting |
| `Ctrl + A`   | Select all              |

### Buffers

| Key          | Action          |
| ------------ | --------------- |
| `Space + BN` | Next buffer     |
| `Space + BP` | Previous buffer |
| `Space + X`  | Close buffer    |
| `Space + B`  | New buffer      |

### Windows

| Key          | Action           |
| ------------ | ---------------- |
| `Space + V`  | Vertical split   |
| `Space + H`  | Horizontal split |
| `Space + SE` | Equalize splits  |
| `Space + XS` | Close split      |
| `Ctrl + H`   | Move left        |
| `Ctrl + J`   | Move down        |
| `Ctrl + K`   | Move up          |
| `Ctrl + L`   | Move right       |

### Tabs

| Key          | Action       |
| ------------ | ------------ |
| `Space + TO` | New tab      |
| `Space + TX` | Close tab    |
| `Space + TN` | Next tab     |
| `Space + TP` | Previous tab |

### Navigation

| Key          | Action                 |
| ------------ | ---------------------- |
| `Ctrl + D`   | Scroll down & center   |
| `Ctrl + U`   | Scroll up & center     |
| `N`          | Next search result     |
| `Shift + N`  | Previous search result |
| `Space + LW` | Toggle line wrapping   |
| `Space + \`  | Toggle Neo-tree        |

### Diagnostics

| Key         | Action              |
| ----------- | ------------------- |
| `[D`        | Previous diagnostic |
| `]D`        | Next diagnostic     |
| `Space + D` | Show diagnostic     |
| `Space + Q` | Diagnostics list    |

## Structure

```text
.
├── init.lua
├── lua
│   ├── core
│   │   ├── keymaps.lua
│   │   └── options.lua
│   └── plugins
│       ├── alpha.lua
│       ├── autocompletion.lua
│       ├── bufferline.lua
│       ├── colortheme.lua
│       ├── gitsigns.lua
│       ├── indent-blankline.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── misc.lua
│       ├── neotree.lua
│       ├── none-ls.lua
│       ├── telescope.lua
│       └── treesitter.lua
└── nvim-pack-lock.json
```

## Install

```bash
git clone https://github.com/YOUR_USERNAME/darling.nvim ~/.config/nvim
nvim
```

> Requires a recent Neovim version.

---

Made with ❤️ and way too much time spent tweaking Neovim.
