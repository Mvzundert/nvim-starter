-- =============================================================================
-- Starter Neovim Config
--
-- Drop this file at ~/.config/nvim/init.lua, or run install.sh.
-- Plugins auto-install on first launch. No manual steps needed.
--
-- Requires Neovim >= 0.11 (for built-in vim.pack.add)
-- =============================================================================

-- Common first tweaks (lines to edit when you're ready to personalize):
--   Line 34 — colorscheme:    change 'tokyonight' to another theme
--   Line 44 — indent size:    change shiftwidth/tabstop from 2 to 4
--   Line 21 — plugins:        add or remove entries in vim.pack.add()
--

-- 1 ─ Leader keys ────────────────────────────────────────────────────────────
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 2 ─ Plugins (auto-installed by Neovim's built-in vim.pack.add) ─────────────
vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim', name = 'tokyonight.nvim' },
  { src = 'https://github.com/folke/which-key.nvim', name = 'which-key.nvim' },
  { src = 'https://github.com/folke/snacks.nvim', name = 'snacks.nvim' },
  { src = 'https://github.com/williamboman/mason.nvim', name = 'mason.nvim' },
  { src = 'https://github.com/williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig', name = 'nvim-lspconfig' },
  { src = 'https://github.com/saghen/blink.cmp', name = 'blink.cmp' },
  { src = 'https://github.com/saghen/blink.lib', name = 'blink.lib' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim', name = 'gitsigns.nvim' },
}, { confirm = false })

-- 3 ─ Colorscheme ────────────────────────────────────────────────────────────
-- If icons look broken or missing, install a Nerd Font: https://www.nerdfonts.com/
vim.cmd.colorscheme('tokyonight')

-- 4 ─ Options ────────────────────────────────────────────────────────────────
vim.opt.number = true                  -- line numbers
vim.opt.mouse = 'a'                    -- allow mouse (helpful early on)
vim.opt.clipboard = 'unnamedplus'      -- sync with system clipboard
vim.opt.ignorecase = true              -- case-insensitive search...
vim.opt.smartcase = true               -- ...unless you type capitals
vim.opt.termguicolors = true           -- 24-bit color support
vim.opt.expandtab = true               -- spaces instead of tabs
vim.opt.shiftwidth = 2                 -- 2-space indent
vim.opt.tabstop = 2
vim.opt.signcolumn = 'yes'             -- always show gutter
vim.opt.splitright = true              -- vertical splits go right
vim.opt.splitbelow = true              -- horizontal splits go below
vim.opt.cursorline = true              -- highlight current line
vim.opt.scrolloff = 4                  -- keep some context around cursor
vim.opt.confirm = true                  -- dialog on unsaved changes instead of error
vim.opt.inccommand = 'split'            -- live preview of :s substitutions
vim.opt.updatetime = 250               -- faster LSP diagnostics
vim.opt.timeoutlen = 300               -- faster which-key popup
vim.opt.wrap = false                   -- no line wrapping in code

-- Persistent undo history — files accumulate in ~/.local/state/nvim/undo/
-- Clean up periodically:  rm -rf ~/.local/state/nvim/undo/
vim.opt.undofile = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.list = true                     -- show invisible characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- 5 ─ Escape Insert mode with jk ─────────────────────────────────────────────
vim.keymap.set('i', 'jk', '<Esc>')

-- 6 ─ Essential keymaps (press <Space> and wait for which-key menu) ──────────

vim.keymap.set('n', '<leader>sf', function()
  Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sg', function()
  Snacks.picker.grep()
end, { desc = '[S]earch [G]rep' })

vim.keymap.set('n', '<leader>bb', function()
  Snacks.picker.buffers()
end, { desc = '[B]uffer [B]rowse' })

vim.keymap.set('n', '<leader>tt', function()
  Snacks.terminal()
end, { desc = '[T]erminal [T]oggle' })

vim.keymap.set('n', '<leader>cm', '<cmd>Mason<CR>', { desc = '[C]heck Mason (install LSPs)' })

vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite (save)' })
vim.keymap.set('n', '<leader>q', '<cmd>close<CR>', { desc = '[Q]uit buffer' })

-- Clear search highlights with Escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better indent — keep selection in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- 7 ─ LSP: Language Server Protocol ──────────────────────────────────────────

-- Auto-attach keymaps and features when an LSP server connects to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('starter-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', vim.lsp.buf.definition, 'Goto Definition')
    map('gr', vim.lsp.buf.references, 'Goto References')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

    -- Highlight references on cursor hold
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Merge blink.cmp capabilities into all LSP servers
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
})

-- 8 ─ Mason: install language servers with a UI ──────────────────────────────
require('mason').setup()

-- Auto-configure servers installed through Mason using nvim-lspconfig
require('mason-lspconfig').setup({
  automatic_installation = false,     -- install servers manually via :Mason
})

-- 9 ─ blink.cmp: auto-completion ─────────────────────────────────────────────
require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  completion = {
    menu = { border = 'rounded' },
    documentation = { window = { border = 'rounded' }, auto_show = true },
  },
})

-- 10 ─ Gitsigns: git change indicators in the gutter ─────────────────────────
require('gitsigns').setup()

-- 11 ─ Snacks: fuzzy finder, terminal, UI polish ─────────────────────────────
require('snacks').setup({
  terminal = { enabled = true },
  picker = {
    matcher = {
      fuzzy = true,
      smartcase = true,
      filename_bonus = true,
    },
  },
})
