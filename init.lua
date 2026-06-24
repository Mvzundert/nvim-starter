-- =============================================================================
-- Starter Neovim Config
--
-- Drop this file at ~/.config/nvim/init.lua, or run install.sh.
-- Plugins auto-install on first launch. No manual steps needed.
--
-- Requires Neovim >= 0.12
-- =============================================================================

-- Common first tweaks (lines to edit when you're ready to personalize):
--   Line  55 — colorscheme:        change 'tokyonight' to another theme
--   Line  65 — indent size:        change shiftwidth/tabstop from 2 to 4
--   Line  25 — plugins:            add or remove entries in vim.pack.add()
--
-- The fallback indent (2 spaces) is overridden per-file by guess-indent.nvim
-- which auto-detects the project's indentation. Adjust both values together.

-- 0 ─ Loader (faster startup) ────────────────────────────────────────────────
vim.loader.enable()

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
  { src = 'https://github.com/NMAC427/guess-indent.nvim', name = 'guess-indent.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip', name = 'LuaSnip', version = vim.version.range '2.*' },
}, { confirm = false })

-- Build hook: LuaSnip needs 'make install_jsregexp' for advanced snippet transforms
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'LuaSnip' and vim.fn.has('win32') ~= 1 and vim.fn.executable('make') == 1 then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path }):wait()
    end
  end,
})

-- 3 ─ Which-key: keymap popup after pressing <Space> ─────────────────────────
require('which-key').setup({
  spec = {
    { '<leader>s', group = 'Search' },
    { '<leader>b', group = 'Buffers' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>c', group = 'Config / Mason' },
    { '<leader>f', group = 'Format' },
  },
})

-- 4 ─ Colorscheme ────────────────────────────────────────────────────────────
-- If icons look broken or missing, install a Nerd Font: https://www.nerdfonts.com/
vim.cmd.colorscheme('tokyonight')

-- 5 ─ Options ────────────────────────────────────────────────────────────────
vim.opt.number = true                  -- line numbers
vim.opt.mouse = 'a'                    -- allow mouse (helpful early on)
vim.opt.clipboard = 'unnamedplus'      -- sync with system clipboard
vim.opt.ignorecase = true              -- case-insensitive search...
vim.opt.smartcase = true               -- ...unless you type capitals
vim.opt.termguicolors = true           -- 24-bit color support
vim.opt.expandtab = true               -- spaces instead of tabs
vim.opt.shiftwidth = 2                 -- fallback indent (guess-indent overrides per-file)
vim.opt.tabstop = 2
vim.opt.signcolumn = 'yes'             -- always show gutter
vim.opt.splitright = true              -- vertical splits go right
vim.opt.splitbelow = true              -- horizontal splits go below
vim.opt.cursorline = true              -- highlight current line
vim.opt.scrolloff = 4                  -- keep some context around cursor
vim.opt.confirm = true                 -- dialog on unsaved changes instead of error
vim.opt.inccommand = 'split'           -- live preview of :s substitutions
vim.opt.updatetime = 250               -- faster LSP diagnostics
vim.opt.timeoutlen = 300               -- faster which-key popup
vim.opt.showmode = false               -- already shown in the statusline
vim.opt.breakindent = true             -- wrapped lines keep their indentation
vim.opt.wrap = false                   -- no line wrapping in code

-- Persistent undo history — files accumulate in ~/.local/state/nvim/undo/
-- Clean up periodically:  rm -rf ~/.local/state/nvim/undo/
vim.opt.undofile = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.list = true                    -- show invisible characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Auto-detect indentation per file — overrides shiftwidth/tabstop above
require('guess-indent').setup {}

-- 6 ─ Escape Insert mode with jk ─────────────────────────────────────────────
vim.keymap.set('i', 'jk', '<Esc>')

-- 6 ─ which-key: press <Space> and wait for a descriptive menu ───────────────
require('which-key').setup({
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>b', group = '[B]uffer' },
    { '<leader>t', group = '[T]erminal' },
    { '<leader>c', group = '[C]ode' },
    { '<leader>r', group = '[R]ename' },
  },
})

-- 7 ─ Essential keymaps (press <Space> and wait for which-key menu) ──────────
-- 7 ─ Yank highlight — flash yanked text briefly ─────────────────────────────
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Flash yanked text',
  group = vim.api.nvim_create_augroup('starter-yank', { clear = true }),
  callback = function() vim.hl.hl_op() end,
})

-- 8 ─ Essential keymaps (press <Space> and wait for which-key menu) ──────────

-- Search
vim.keymap.set('n', '<leader>sf', function()
  Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sg', function()
  Snacks.picker.grep()
end, { desc = '[S]earch [G]rep' })

vim.keymap.set('n', '<leader>sh', function()
  Snacks.picker.help()
end, { desc = '[S]earch [H]elp' })

vim.keymap.set('n', '<leader>sk', function()
  Snacks.picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })

vim.keymap.set('n', '<leader>s.', function()
  Snacks.picker.recent()
end, { desc = '[S]earch recent files ("." for repeat)' })

-- Buffers
vim.keymap.set('n', '<leader>bb', function()
  Snacks.picker.buffers()
end, { desc = '[B]uffer [B]rowse' })

-- Toggle
vim.keymap.set('n', '<leader>tt', function()
  Snacks.terminal()
end, { desc = '[T]erminal [T]oggle' })

-- Exit terminal mode (easier for beginners than <C-\><C-n>)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Config / Mason
vim.keymap.set('n', '<leader>cm', '<cmd>Mason<CR>', { desc = '[C]heck [M]ason (install LSPs)' })

-- Format
vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format { async = true }
end, { desc = '[F]ormat buffer' })

-- File
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite (save)' })
vim.keymap.set('n', '<leader>q', '<cmd>close<CR>', { desc = '[Q]uit buffer' })

-- Clear search highlights with Escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Split navigation — Ctrl + hjkl to move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- Better indent — keep selection in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- 8 ─ LSP: Language Server Protocol ──────────────────────────────────────────
-- 9 ─ Diagnostics: better error display ──────────────────────────────────────
vim.diagnostic.config {
  update_in_insert = false,         -- less visual noise while typing
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  virtual_text = true,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
    end,
  },
}

-- 10 ─ LSP: Language Server Protocol ─────────────────────────────────────────

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

-- 9 ─ Mason: install language servers with a UI ──────────────────────────────
-- 11 ─ Mason: install language servers with a UI ─────────────────────────────
require('mason').setup()

-- Auto-configure servers installed through Mason using nvim-lspconfig
require('mason-lspconfig').setup({
  automatic_installation = false,     -- install servers manually via :Mason
})

-- 10 ─ blink.cmp: auto-completion ─────────────────────────────────────────────
-- 12 ─ LuaSnip: snippet engine (powers the 'snippets' source in blink.cmp) ──
require('luasnip').setup {}

-- 13 ─ blink.cmp: auto-completion ────────────────────────────────────────────
require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
  },
  fuzzy = { implementation = 'lua' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  snippets = {
    preset = 'luasnip',
  },
  completion = {
    menu = { border = 'rounded' },
    documentation = { window = { border = 'rounded' }, auto_show = true },
  },
  signature = { enabled = true },
})

-- 11 ─ Gitsigns: git change indicators in the gutter ─────────────────────────
require('gitsigns').setup()

-- 12 ─ Snacks: fuzzy finder, terminal, UI polish ─────────────────────────────
-- 14 ─ Gitsigns: git change indicators in the gutter ─────────────────────────
require('gitsigns').setup()

-- 15 ─ Snacks: fuzzy finder, terminal, UI polish ─────────────────────────────
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

-- 16 ─ Treesitter: better syntax highlighting (built into Neovim >= 0.12) ────
--
-- Neovim 0.12 ships parsers for C, Lua, Markdown, Vimscript, Vimdoc, and
-- Query files. Treesitter highlighting works automatically for those.
-- Install additional parsers via your OS package manager or tree-sitter CLI:
--   tree-sitter install python
--   tree-sitter install rust
--   tree-sitter install bash
--
-- The autocmd below tries to enable treesitter for every filetype and
-- silently skips languages without a parser installed.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('starter-treesitter', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then return end

    local has_parser = vim.treesitter.language.add(lang)
    if not has_parser then return end

    pcall(vim.treesitter.start, args.buf, lang)
  end,
})
