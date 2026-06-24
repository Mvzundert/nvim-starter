# Verifying LSP Works

After installing a language server in Mason, confirm everything is wired up
correctly.

Open a file of that language (e.g., `nvim test.py`) and run these checks:

| Check | How | What you should see |
|---|---|---|
| LSP attached | `:checkhealth vim.lsp` | Server listed as "attached" |
| Completion works | Type `import os` then `os.` | Popup with functions |
| Go-to-definition | Place cursor on a function call, press `gd` | Jumps to definition |
| Hover docs | Place cursor on a symbol, press `K` | Floating documentation window |
| Diagnostics | Make a syntax error, wait 1 second | Red underline and gutter marker |
| Manual completion | Press `<C-Space>` | Force-opens the completion menu |

## If something isn't working

- `:checkhealth vim.lsp` shows "no client attached" — install the server in
  `:Mason` and reopen the file.
- Completion doesn't appear — make sure the file type is detected. Try `:set
  ft?` — it should show the language (e.g., `filetype=python`). If not, use
  `:set ft=python`.
- Diagnostics don't show — check `:checkhealth vim.lsp` to confirm the server
  is running. Some servers need a few seconds to start.
- Completion menu appears but has no LSP results — press `<C-Space>` to force
  the menu. If still empty, check `:checkhealth vim.lsp` for a running server.

Still stuck? See [Troubleshooting](troubleshooting.md) or ask in a
[GitHub Discussion](https://github.com/Mvzundert/nvim-starter/discussions).
