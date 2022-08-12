local colors = require("fky.theme").colors

local map_opts = { silent = true }
-- nvim-tree
vim.keymap.set("", "<F2>", ":NvimTreeToggle<CR>", map_opts)
vim.keymap.set("!", "<F2>", "<C-O>:NvimTreeToggle<CR>", map_opts)
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", map_opts)

-- SymbolsOutline
vim.keymap.set("", "<F3>", ":SymbolsOutline<CR>", map_opts)
vim.keymap.set("!", "<F3>", "<C-O>:SymbolsOutline<CR>", map_opts)
vim.g.symbols_outline = {
  width = 45,
}

-- FTerm
vim.keymap.set("n", "<F4>", '<CMD>lua require("FTerm").toggle()<CR>', map_opts)
vim.keymap.set("t", "<F4>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', map_opts)
vim.keymap.set("i", "<F4>", '<C-O><CMD>lua require("FTerm").toggle()<CR>', map_opts)

-- animate.vim
vim.keymap.set("n", "<Up>", ":call animate#window_delta_height(10)<CR>", map_opts)
vim.keymap.set("n", "<Down>", ":call animate#window_delta_height(-10)<CR>", map_opts)
vim.keymap.set("n", "<Left>", ":call animate#window_delta_width(10)<CR>", map_opts)
vim.keymap.set("n", "<Right>", ":call animate#window_delta_width(-10)<CR>", map_opts)

-- numToStr/Comment.nvim
require("Comment").setup()

require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input", "lsp_installer", "" },
})

--- Git Relative

-- gitsigns.nvim
require("gitsigns").setup {
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

vim.g.indent_blankline_filetype_exclude = { "alpha", "FTerm", "toggleterm" }

require("indent_blankline").setup({
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
})

vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.tex_flavor = "latex"

-- require("neoscroll").setup()

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  shade_terminals = false,
})

-- if you use `<CR>` as toggle, then you should handle when to fallback yourself so it won't intercept the plain-old `<CR>`.
vim.keymap.set("n", "<leader>z", ":NeoZoomToggle<CR>", { silent = true, nowait = true })

-- barbar.nvim
local map = vim.keymap.set
local map_opts = { silent = true }

-- Move to previous/next
map("n", "<A-,>", ":BufferPrevious<CR>", map_opts)
map("n", "<A-.>", ":BufferNext<CR>", map_opts)
-- Re-order to previous/next
map("n", "<A-<>", ":BufferMovePrevious<CR>", map_opts)
map("n", "<A->>", " :BufferMoveNext<CR>", map_opts)
-- Goto buffer in position...
map("n", "<A-1>", ":BufferGoto 1<CR>", map_opts)
map("n", "<A-2>", ":BufferGoto 2<CR>", map_opts)
map("n", "<A-3>", ":BufferGoto 3<CR>", map_opts)
map("n", "<A-4>", ":BufferGoto 4<CR>", map_opts)
map("n", "<A-5>", ":BufferGoto 5<CR>", map_opts)
map("n", "<A-6>", ":BufferGoto 6<CR>", map_opts)
map("n", "<A-7>", ":BufferGoto 7<CR>", map_opts)
map("n", "<A-8>", ":BufferGoto 8<CR>", map_opts)
map("n", "<A-9>", ":BufferGoto 9<CR>", map_opts)
map("n", "<A-0>", ":BufferLast<CR>", map_opts)
-- Close buffer
map("n", "<A-c>", ":BufferClose<CR>", map_opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map("n", "<C-p>", ":BufferPick<CR>", map_opts)
-- Sort automatically by...
map("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>", map_opts)
map("n", "<Space>bd", ":BufferOrderByDirectory<CR>", map_opts)
map("n", "<Space>bl", ":BufferOrderByLanguage<CR>", map_opts)

-- Tmux Navigator
map("n", "<A-j>", ":TmuxNavigateDown<CR>", map_opts)
map("n", "<A-k>", ":TmuxNavigateUp<CR>", map_opts)
map("n", "<A-h>", ":TmuxNavigateLeft<CR>", map_opts)
map("n", "<A-l>", ":TmuxNavigateRight<CR>", map_opts)
map("n", "<A-\\>", ":TmuxNavigatePrevious<CR>", map_opts)

-- Copilot

map("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, unpack(map_opts) })
-- imap <silent><script><expr>
vim.g.copilot_no_tab_map = true

-- which-key.nvim

-- TODO: maybe we should map all keybind here.
local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    name = "Find",
    n = { "Find current file in NvimTree" },
  },
})

-- neogen
vim.keymap.set("n", "<leader>g", ":lua require('neogen').generate()<CR>", map_opts)

-- scrollbar
require("scrollbar").setup({
  handle = {
    color = colors.bg_highlight,
  },
  marks = {
    Search = { color = colors.orange },
    Error = { color = colors.error },
    Warn = { color = colors.warning },
    Info = { color = colors.info },
    Hint = { color = colors.hint },
    Misc = { color = colors.cyan },
  },
  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "qf",
    "alpha",
  },
})

require("qf_helper").setup()

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})

-- NeoRoot.lua
-- local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
-- vim.cmd'au BufEnter * NeoRoot'
-- vim.keymap.set('n', '<Leader>p', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
-- vim.keymap.set('n', '<Leader>pre', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)
--

vim.keymap.set('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  map_opts)
vim.keymap.set('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  map_opts)
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], map_opts)
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], map_opts)
vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], map_opts)
vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], map_opts)

-- trouble.nvim
vim.keymap.set('n', '<leader>xx', '<CMD>TroubleToggle<CR>', map_opts)
vim.keymap.set('n', '<leader>xw', '<CMD>TroubleToggle workspace_diagnostics<CR>', map_opts)
vim.keymap.set('n', '<leader>xd', '<CMD>TroubleToggle document_diagnostics<CR>', map_opts)
vim.keymap.set('n', '<leader>xq', '<CMD>TroubleToggle quickfix<CR>', map_opts)
vim.keymap.set('n', '<leader>xl', '<CMD>TroubleToggle loclist<CR>', map_opts)
vim.keymap.set('n', 'gR', '<CMD>TroubleToggle lsp_references<CR>', map_opts)
