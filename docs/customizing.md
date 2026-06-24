# Customizing Your Config

The starter config is meant to be read and edited. Everything is in one file
(`init.lua`), heavily commented, and organized into numbered sections.

**Quick reference** — the top of `init.lua` has a "Common first tweaks" block
pointing you to the 3 most common changes. Start there.

---

## Change the colorscheme

The colorscheme is set on line 64:

```lua
vim.cmd.colorscheme('tokyonight')
```

Replace `'tokyonight'` with any installed colorscheme name. To install a new
one, see [Switching Colorschemes](themes.md).

Tokyo night has four variants — add this before the colorscheme line:

```lua
require('tokyonight').setup({ style = 'storm' })  -- 'night', 'day', 'moon'
```

---

## Change indent size

Lines 74-75 control how wide indentation is:

```lua
vim.opt.shiftwidth = 4   -- indent width
vim.opt.tabstop = 4      -- tab display width
```

Set both to the same number (2, 4, or 8 are common).

---

## Add files to search ignore

By default, the fuzzy finder searches everything. To skip certain paths, add
them to the Snacks picker config in section 15:

```lua
require('snacks').setup({
  picker = {
    hidden = false,
    ignored = true,
    sources = {
      files = {
        hidden = false,
        ignored = true,
      },
    },
  },
})
```

This respects `.gitignore` automatically. Add a root `.gitignore` to your
projects to exclude `node_modules`, `.venv`, etc.

---

## Add LSP keybindings

Section 10 (line 191) defines keymaps that activate when a language server
attaches. Add more inside the `map()` calls:

```lua
map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
map('<leader>gt', vim.lsp.buf.type_definition, 'Goto Type Definition')
map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
```

Every built-in LSP function is documented at `:help lsp-buf`.

---

## Add plugins

Add entries to the `vim.pack.add()` list (line 26):

```lua
{ src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', name = 'neo-tree.nvim' },
```

Then configure the plugin in a new section at the bottom:

```lua
-- 17 ─ Neo-tree: file explorer ───────────────────────────────────
require('neo-tree').setup({
  window = { position = 'right' },
})

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file tree' })
```

See [Popular Plugins](plugins.md) for recommendations and ready-to-paste
snippets.

---

## Remove plugins

Delete the `{ src = ..., name = ... }` line from `vim.pack.add()`, its
`require('...').setup()` call, and any related keymaps. Neovim won't delete
the cached files — they stay in `~/.local/share/nvim/site/pack/` for undo
history but won't load.

---

## Understanding the file

`init.lua` is organized in numbered sections (0 through 16). Each section starts
with a comment header and a brief explanation. The `vim.pack.add()` at the top
tells Neovim to auto-clone and load plugins. A `PackChanged` build hook compiles
LuaSnip's regex engine after install. Everything below is options, keymaps, and
plugin configuration — in that order.

Read it top to bottom once. It's 299 lines of commented Lua — about 10 minutes.
