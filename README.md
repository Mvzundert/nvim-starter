# Starter Neovim Config

A single-file, beginner-friendly Neovim setup with 10 plugins, sensible defaults,
thoroughly commented code, and a curated set of keybindings to get productive quickly.

**What this gives you:**

| You get | Provided by |
|---|---|
| Dark colorscheme (tokyonight) | tokyonight.nvim |
| Keymap cheat sheet — press `<Space>` and wait | which-key.nvim |
| Fuzzy file finder, text search, terminal | snacks.nvim |
| Language server installer (GUI) | mason.nvim |
| Go-to-definition, hover docs, rename, diagnostics | nvim-lspconfig |
| Auto-completion + snippet expansion | blink.cmp + LuaSnip |
| Function signature help while typing | blink.cmp (signature) |
| Git change markers in the gutter | gitsigns.nvim |
| Auto-detect project indentation | guess-indent.nvim |
| Better syntax highlighting (C, Lua, Markdown, …) | built-in treesitter |
| Format buffer via LSP | built-in LSP (`<leader>f`) |

Everything is in one file. Read it, understand it, then tweak it.

---

## Prerequisites

- **Neovim >= 0.12** — required for built-in `vim.pack.add()` and native treesitter
- **Git** — needed to clone plugins on first launch
- **Nerd Font** (optional) — makes icons in which-key and gitsigns look right.
  [Download a Nerd Font](https://www.nerdfonts.com/) if you see missing glyphs.

Check your versions:

```bash
nvim --version | head -1
git --version
```

---

## Installation

### Option A: One-command install

```bash
curl -fsSL https://raw.githubusercontent.com/Mvzundert/nvim-starter/main/install.sh | bash
```

This backs up your existing `~/.config/nvim/init.lua` and copies the starter config into place.

### Option B: Manual

```bash
mkdir -p ~/.config/nvim
cp starter/init.lua ~/.config/nvim/init.lua
```

If you already have an `init.lua`, back it up first:

```bash
cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
```

### Option C: Try without installing

```bash
nvim -u starter/init.lua somefile.py
```

Your real config stays untouched. Useful for testing before committing.

---

## First launch

Open Neovim on any file:

```bash
nvim hello.py
```

**What happens:**

1. **Plugins auto-install.** You'll see git clone output for ~30 seconds. This
   happens once. On subsequent launches Neovim starts instantly.
2. **tokyonight colorscheme applies.** Dark background, syntax highlighting.
3. **which-key is active.** Tap `<Space>` and wait half a second — a menu of
   available keybindings appears.
4. **LuaSnip compiles its regex engine.** A one-time build step runs after install.
   You won't notice it — it's silent unless it fails.

If plugins fail to install, check that `git` is available and you have a working
internet connection.

**Your first two keybindings to learn:**

- `<Space>sh` — search help (`:help` is your best friend in Neovim)
- `<Space>sk` — list every keybinding and what it does

---

## Installing language servers

Language servers (LSPs) power go-to-definition, auto-completion, hover docs, and
diagnostics. They must be installed separately — one per language.

### Step-by-step

1. Open a file of the language you want support for (e.g. `nvim main.py`)
2. Press `<Space>cm` to open **Mason**
3. In the Mason window:
   - Press `2` to view language servers
   - Use `/` to search (e.g. `/pyright` for Python)
   - Press `i` on the server you want to install
4. Press `q` to close Mason
5. Reopen your file — the LSP attaches automatically (auto-complete, go-to-definition, diagnostics, and hover docs all work)

**How it works:** `mason-lspconfig` detects installed servers and auto-enables
them via Neovim's built-in `vim.lsp.enable()`. You don't need to write
per-server config blocks — `automatic_enable = true` wires everything up.

**Completion:** blink.cmp shows suggestions as you type. Press `<C-Space>` to
force the menu open. `<C-n>` / `<C-p>` cycle, `<C-y>` accepts, `<Tab>` jumps
between snippet placeholders.

**To verify:** run `:checkhealth vim.lsp` inside Neovim. It lists every running
language server and which buffers they're attached to.

See [Language Servers](docs/lsp-servers.md) for a full list of recommended servers per language (Python, Rust, Go, JS/TS, Lua, and more). Confirm it's working → [Verifying LSP works](docs/verify.md).

---

## Keybindings

### Core (always active)

| Keys | Action |
|---|---|
| `jk` | Exit Insert mode (no reaching for `Esc`) |
| `<Space>` | Hold, then wait for which-key to show all keybindings |

### Window navigation

| Keys | Action |
|---|---|
| `Ctrl-h` | Focus left window |
| `Ctrl-l` | Focus right window |
| `Ctrl-j` | Focus lower window |
| `Ctrl-k` | Focus upper window |

### Fuzzy finder (`<Space> s...`)

| Keys | Action |
|---|---|
| `<Space>sf` | Search files by name |
| `<Space>sg` | Search files by content (grep) |
| `<Space>sh` | Search help (`:help` pages) |
| `<Space>sk` | List all keybindings |
| `<Space>s.` | Recent files (reopen something you closed) |

### Buffers (`<Space> b...`)

| Keys | Action |
|---|---|
| `<Space>bb` | Browse open buffers |

### File / format

| Keys | Action |
|---|---|
| `<Space>w` | Save current file |
| `<Space>q` | Close current buffer |
| `<Space>f` | Format buffer (via LSP) |

### Tools (`<Space> c...` / `<Space> t...`)

| Keys | Action |
|---|---|
| `<Space>cm` | Open Mason (install LSP servers) |
| `<Space>tt` | Toggle terminal |
| `<Esc><Esc>` | Exit terminal mode (while inside terminal) |

### LSP (active when a language server is attached)

| Keys | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `[d` / `]d` | Previous / next diagnostic |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions (quick-fix menu) |

### Completion (blink.cmp)

| Keys | Action |
|---|---|
| Type text | Auto-complete appears as you type |
| `<C-Space>` | Manually open completion menu |
| `<C-n>` / `<C-p>` | Next / previous suggestion |
| `<C-y>` | Accept suggestion |
| `<Tab>` | Jump to next snippet placeholder |
| `<S-Tab>` | Previous snippet placeholder |

### Vim built-ins (always available)

| Keys | Action |
|---|---|
| `:q` | Quit |
| `:q!` | Force quit (discard changes) |
| `:w` | Save |
| `:wq` | Save and quit |
| `u` | Undo |
| `Ctrl-r` | Redo |

---

[Customizing your config](docs/customizing.md) — change colorscheme, indent size, add plugins, create keybindings.

---

## Questions?

If something isn't working or you have ideas to improve this starter config —
open a [GitHub Discussion](https://github.com/Mvzundert/nvim-starter/discussions).
I usually try to answer within a day or two.

---

## Further reading

| What | Where |
|---|---|
| Popular plugins (file tree, statusline, formatter) | [docs/plugins.md](docs/plugins.md) |
| Switch colorscheme (catppuccin, rose-pine, etc.) | [docs/themes.md](docs/themes.md) |
| LSP server list per language | [docs/lsp-servers.md](docs/lsp-servers.md) |
| Customize the config (colors, indents, plugins) | [docs/customizing.md](docs/customizing.md) |
| Something broke? Fixes for common issues | [docs/troubleshooting.md](docs/troubleshooting.md) |
| Next steps (vimtutor, learning resources) | [docs/next-steps.md](docs/next-steps.md) |

---

## Uninstalling

```bash
rm ~/.config/nvim/init.lua
```

If you had a backup, restore it:

```bash
cp ~/.config/nvim/init.lua.bak.XXXXXXXXXX ~/.config/nvim/init.lua
```

Plugins are cached in `~/.local/share/nvim/site/pack/`. Remove them if you want
a completely clean slate:

```bash
rm -rf ~/.local/share/nvim/site/pack/
```
