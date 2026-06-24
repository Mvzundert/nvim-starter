# Switching Colorschemes

The starter config uses [tokyonight](https://github.com/folke/tokyonight.nvim)
(moon variant). Switching themes takes 3 steps.

---

## The 3-step recipe

Add the plugin, call its setup function, then change the colorscheme name.

Here's how you'd switch to catppuccin:

```lua
-- 1. Add to the vim.pack.add() list (near line 26 in init.lua):
{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' }

-- 2. Add setup before the colorscheme line (near line 51):
require('catppuccin').setup({ flavour = 'mocha' })

-- 3. Change the colorscheme call:
vim.cmd.colorscheme('catppuccin')
```

Same pattern works for every theme below.

---

## Popular themes

| Theme | `vim.pack.add()` entry | Colorscheme name |
|---|---|---|
| [catppuccin](https://github.com/catppuccin/nvim) | `{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' }` | `catppuccin` |
| [rose-pine](https://github.com/rose-pine/neovim) | `{ src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' }` | `rose-pine` |
| [kanagawa](https://github.com/rebelot/kanagawa.nvim) | `{ src = 'https://github.com/rebelot/kanagawa.nvim', name = 'kanagawa.nvim' }` | `kanagawa` |
| [gruvbox](https://github.com/ellisonleao/gruvbox.nvim) | `{ src = 'https://github.com/ellisonleao/gruvbox.nvim', name = 'gruvbox.nvim' }` | `gruvbox` |
| [everforest](https://github.com/neanias/everforest-nvim) | `{ src = 'https://github.com/neanias/everforest-nvim', name = 'everforest-nvim' }` | `everforest` |

Each theme has multiple style variants (dark, light, etc.). Check the theme's
README for setup options.

---

## Still using tokyonight?

Tokyo night has four built-in variants. Add this before the colorscheme line:

```lua
require('tokyonight').setup({ style = 'storm' })  -- try 'night', 'day', 'moon'
```
