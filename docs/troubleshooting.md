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

## Still stuck?

Open a [GitHub Discussion](https://github.com/Mvzundert/nvim-starter/discussions).
Describe what you were trying to do, what you expected, and what happened
instead. Include your Neovim version (`nvim --version | head -1`).
