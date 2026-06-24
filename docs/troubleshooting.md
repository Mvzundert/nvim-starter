# Troubleshooting

## Plugins fail to install (git errors)

Check that git is installed and on your PATH:

```bash
git --version
```

If you're behind a corporate proxy, configure it:

```bash
git config --global http.proxy http://proxy:port
```

## Clipboard doesn't sync with system

The `unnamedplus` clipboard option requires a clipboard provider.

- **Linux (X11):** `sudo apt install xclip` (or `xsel`)
- **Linux (Wayland):** `sudo apt install wl-clipboard`
- **macOS:** `pbcopy` is built-in — works out of the box.

## `jk` doesn't escape Insert mode

The timeout may be too fast. Try pressing `j` then `k` within 300ms — the
timeout is set on line 84. If it still fails, check that you haven't remapped
`j` or `k` elsewhere.

## Icons look broken or missing

The starter config uses a Nerd Font for which-key and gitsigns icons. If you see
boxes or question marks:

1. [Download a Nerd Font](https://www.nerdfonts.com/) (FiraCode Nerd Font or
   JetBrains Mono Nerd Font are popular choices)
2. Install it on your system
3. Set it as your terminal font
4. Relaunch your terminal

## No syntax highlighting

Make sure `termguicolors` is enabled (line 72 in `init.lua`) and your terminal
supports 24-bit color. Most modern terminals do — check your terminal's
settings if colors look wrong.

## Error: "vim.pack.add is nil" or plugins don't load

You're running Neovim < 0.12. The starter config requires Neovim 0.12 or newer
for the built-in plugin manager and native treesitter. Update or use the AppImage:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
./nvim.appimage
```

## Plugin cache issues

If plugins behave oddly after updating Neovim, clear the cache and let them
reinstall:

```bash
rm -rf ~/.local/share/nvim/site/pack/
```

Launch Neovim again — plugins re-clone automatically on first start.

## Language server not starting or not attaching

If you installed a language server in Mason but `:checkhealth vim.lsp` shows
"no clients":

1. **Restart Neovim.** `mason-lspconfig` auto-enables servers at startup. A
   server installed mid-session won't attach until Neovim restarts.
2. **Open a file of the right type.** LSP servers attach only to buffers
   whose filetype they recognize (e.g., `intelephense` attaches to `.php`
   files). Run `:set ft?` to confirm the filetype.
3. **Check for errors.** Run `:messages` and look for lines mentioning the
   server name or `vim.lsp`. A crash or missing dependency shows up here.
4. **Reinstall the server.** Open `:Mason`, press `X` on the server to
   uninstall, then `i` to reinstall. Restart Neovim.

## Auto-complete doesn't appear despite LSP running

If `:checkhealth vim.lsp` shows a server attached but completion never
triggers:

1. **Check blink.cmp loaded:** `:lua print(vim.inspect(require("blink.cmp")))`
   should print its config table. If you get an error, blink.cmp failed to
   load — check `:messages` for the error.
2. **Check capability wiring:** Completion requires the LSP server to receive
   completion capabilities during initialization. The starter config merges
   blink.cmp's capabilities via `vim.lsp.config("*")`. If you've overridden
   `vim.lsp.config` for a specific server elsewhere, ensure you merge rather
   than replace the `capabilities` field.
3. **Check completion sources:** blink.cmp uses four sources by default:
   `lsp`, `path`, `snippets`, `buffer`. If only LSP is failing, path
   completions (filenames) should still appear. If *nothing* appears, blink.cmp
   itself is likely not running.
4. **Language server startup time:** Some servers (e.g. `rust-analyzer`,
   `jdtls`) take several seconds to index a project. Completion won't appear
   until indexing finishes. Watch the statusline or run
   `:checkhealth vim.lsp` to see if the server has a "running" or
   "initialized" status.
5. **File type detection:** Run `:set ft?` to confirm the file type is
   detected. If it shows an unexpected value, the LSP server for your
   language won't attach. Use `:set ft=python` (or your language) to
   force it temporarily.

## Still stuck?

Open a [GitHub Discussion](https://github.com/Mvzundert/nvim-starter/discussions).
Describe what you were trying to do, what you expected, and what happened
instead. Include your Neovim version (`nvim --version | head -1`).
