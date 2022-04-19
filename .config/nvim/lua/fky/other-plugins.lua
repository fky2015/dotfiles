local colors = require("fky.theme").colors

local opts = { silent = true }
-- nvim-tree
vim.keymap.set("", "<F2>", ":NvimTreeToggle<CR>", opts)
vim.keymap.set("!", "<F2>", "<C-O>:NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", opts)

-- SymbolsOutline
vim.keymap.set("", "<F3>", ":SymbolsOutline<CR>", opts)
vim.keymap.set("!", "<F3>", "<C-O>:SymbolsOutline<CR>", opts)
vim.g.symbols_outline = {
  width = 45,
}

-- FTerm
vim.keymap.set("n", "<F4>", '<CMD>lua require("FTerm").toggle()<CR>', opts)
vim.keymap.set("t", "<F4>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
vim.keymap.set("i", "<F4>", '<C-O><CMD>lua require("FTerm").toggle()<CR>', opts)

-- animate.vim
vim.keymap.set("n", "<Up>", ":call animate#window_delta_height(10)<CR>", opts)
vim.keymap.set("n", "<Down>", ":call animate#window_delta_height(-10)<CR>", opts)
vim.keymap.set("n", "<Left>", ":call animate#window_delta_width(10)<CR>", opts)
vim.keymap.set("n", "<Right>", ":call animate#window_delta_width(-10)<CR>", opts)

-- numToStr/Comment.nvim
require("Comment").setup()

require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input", "lsp_installer", "" },
})

--- Git Relative

-- gitsigns.nvim
require("gitsigns").setup()

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
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-,>", ":BufferPrevious<CR>", opts)
map("n", "<A-.>", ":BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", ":BufferMovePrevious<CR>", opts)
map("n", "<A->>", " :BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", ":BufferGoto 1<CR>", opts)
map("n", "<A-2>", ":BufferGoto 2<CR>", opts)
map("n", "<A-3>", ":BufferGoto 3<CR>", opts)
map("n", "<A-4>", ":BufferGoto 4<CR>", opts)
map("n", "<A-5>", ":BufferGoto 5<CR>", opts)
map("n", "<A-6>", ":BufferGoto 6<CR>", opts)
map("n", "<A-7>", ":BufferGoto 7<CR>", opts)
map("n", "<A-8>", ":BufferGoto 8<CR>", opts)
map("n", "<A-9>", ":BufferGoto 9<CR>", opts)
map("n", "<A-0>", ":BufferLast<CR>", opts)
-- Close buffer
map("n", "<A-c>", ":BufferClose<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map("n", "<C-p>", ":BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bd", ":BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", ":BufferOrderByLanguage<CR>", opts)

-- Tmux Navigator
map("n", "<A-j>", ":TmuxNavigateDown<CR>", opts)
map("n", "<A-k>", ":TmuxNavigateUp<CR>", opts)
map("n", "<A-h>", ":TmuxNavigateLeft<CR>", opts)
map("n", "<A-l>", ":TmuxNavigateRight<CR>", opts)
map("n", "<A-\\>", ":TmuxNavigatePrevious<CR>", opts)

-- Copilot

map("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, unpack(opts) })
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
vim.keymap.set("n", "<leader>g", ":lua require('neogen').generate()<CR>", opts)

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

-- NeoRoot.lua
-- local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
-- vim.cmd'au BufEnter * NeoRoot'
-- vim.keymap.set('n', '<Leader>p', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
-- vim.keymap.set('n', '<Leader>pre', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)
