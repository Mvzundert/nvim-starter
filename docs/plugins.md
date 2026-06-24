# Popular Plugins

Your starter config already has 10 plugins handling colorscheme, completion, LSP,
fuzzy finding, git signs, snippet expansion, auto-indent, and signature help.
Here are other plugins the community loves — add them when you feel ready.

---

## How to add a plugin

Add the `{ src = '...', name = '...' }` entry to the `vim.pack.add()` list in
`init.lua` (around line 26). Then add its setup call at the bottom of the file.

Most plugins need a `require('...').setup()` line. Neovim auto-installs the
plugin on next launch — no extra commands needed.

---

## File tree

See your project in a sidebar.

| Plugin | `vim.pack.add()` entry |
|---|---|
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | `{ src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', name = 'neo-tree.nvim' }` |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | `{ src = 'https://github.com/stevearc/oil.nvim', name = 'oil.nvim' }` |

*neo-tree* is a traditional file tree sidebar. *oil* turns directories into
editable buffers — you rename, delete, and move files like text.

Setup example for neo-tree:

```lua
require('neo-tree').setup({
  window = { position = 'right' },
})

-- keymap to toggle it
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file tree' })
```

---

## Status line

A prettier bar at the bottom showing mode, git branch, LSP status, and cursor position.

| Plugin | `vim.pack.add()` entry |
|---|---|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | `{ src = 'https://github.com/nvim-lualine/lualine.nvim', name = 'lualine.nvim' }` |

```lua
require('lualine').setup()
```

---

## Auto-formatting

Format code on save with tools like Prettier, Black, or Stylua. No more manual
indentation fixes.

| Plugin | `vim.pack.add()` entry |
|---|---|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | `{ src = 'https://github.com/stevearc/conform.nvim', name = 'conform.nvim' }` |

```lua
require('conform').setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
```

You also need the formatter itself installed (e.g., `npm install -g prettier` or
`pip install black`). Mason can install some formatters too — check inside `:Mason`.

---

## Debugging

Set breakpoints, step through code, inspect variables — all inside Neovim.

| Plugin | `vim.pack.add()` entry |
|---|---|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | `{ src = 'https://github.com/mfussenegger/nvim-dap', name = 'nvim-dap' }` |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | `{ src = 'https://github.com/rcarriga/nvim-dap-ui', name = 'nvim-dap-ui' }` |

*nvim-dap* provides the debugger engine. *nvim-dap-ui* adds a visual interface
(breakpoint list, variable inspector, call stack). Both are needed for a full
debugging experience.

Setup varies by language — check each plugin's README for adapter configuration.

---

## Snippets

Predefined code templates you expand while typing (e.g., type `for` and get a
complete for-loop), with tab stops to jump between placeholders.

The starter config already includes [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
and [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) is a
one-line add for hundreds of pre-made snippets:

```lua
-- Add to vim.pack.add():
{ src = 'https://github.com/rafamadriz/friendly-snippets', name = 'friendly-snippets' },

-- Then, after require('luasnip').setup {} (line 235):
require('luasnip.loaders.from_vscode').lazy_load()
```

Snippets appear in the completion menu automatically — press `<Tab>` to expand
them and `<Tab>`/`<S-Tab>` to jump through tab stops.

---

## Git

[lazygit](https://github.com/jesseduffield/lazygit) is a terminal-based git UI
— stage hunks, commit, browse history, resolve conflicts, all with keyboard
shortcuts. It runs inside Neovim's built-in terminal and works with any git repo
instantly.

The starter config already includes `Snacks.terminal()` — lazygit opens there
with one keymap:

```lua
vim.keymap.set('n', '<leader>gg', function()
  Snacks.terminal('lazygit')
end, { desc = 'Open lazygit' })
```

**Installation:** lazygit is a standalone tool, not a Neovim plugin.

- **macOS:** `brew install lazygit`
- **Linux:** check your package manager (`apt install lazygit`, `dnf install lazygit`, etc.)
- **Download:** https://github.com/jesseduffield/lazygit/releases

---

## Questions?

Open a [GitHub Discussion](https://github.com/Mvzundert/nvim-starter/discussions)
if you want plugin recommendations for a specific use case.
