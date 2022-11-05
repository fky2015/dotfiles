local colors = require("fky.theme").colors

local map_opts = { silent = true }
local k = vim.keymap.set

vim.keymap.set("n", ":", "<Plug>Lightspeed_;_ft", { noremap = false })

vim.keymap.set("n", "<leader>pi", ":PackerInstall<CR>")
vim.keymap.set("n", "<leader>ps", ":PackerSync<CR>")
vim.keymap.set("n", "<leader>pc", ":PackerCompile<CR>")

vim.keymap.set("n", "<localleader>f", ":lua require('fky.utils').FoldColumnToggle()<CR>")
vim.keymap.set("n", "<leader>q", ":QFToggle!<CR>")
vim.keymap.set("n", "<leader>l", ":LLToggle!<CR>")

-- telescope
k("n", "<leader>f", "<cmd>Telescope find_files<cr>")
k("n", "<leader>t", "<cmd>Telescope live_grep<cr>")
k("n", "<leader>b", "<cmd>Telescope buffers<cr>")
k("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
k("n", "<leader>s", "<cmd>Telescope treesitter<cr>")

-- nvim-tree
k("", "<F2>", ":NvimTreeToggle<CR>", map_opts)
k("!", "<F2>", "<C-O>:NvimTreeToggle<CR>", map_opts)
k("n", "<leader>n", ":NvimTreeFindFile<CR>", map_opts)

-- https://github.com/simrat39/symbols-outline.nvim
vim.keymap.set("", "<F3>", ":SymbolsOutline<CR>", map_opts)
vim.keymap.set("!", "<F3>", "<C-O>:SymbolsOutline<CR>", map_opts)
require("symbols-outline").setup({
  width = 35,
})

-- FTerm
vim.keymap.set("n", "<F4>", '<CMD>lua require("FTerm").toggle()<CR>', map_opts)
vim.keymap.set("t", "<F4>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', map_opts)
vim.keymap.set("i", "<F4>", '<C-O><CMD>lua require("FTerm").toggle()<CR>', map_opts)

-- animate.vim
vim.keymap.set("n", "<Up>", ":call animate#window_delta_height(10)<CR>", map_opts)
vim.keymap.set("n", "<Down>", ":call animate#window_delta_height(-10)<CR>", map_opts)
vim.keymap.set("n", "<Left>", ":call animate#window_delta_width(10)<CR>", map_opts)
vim.keymap.set("n", "<Right>", ":call animate#window_delta_width(-10)<CR>", map_opts)

-- https://github.com/numToStr/Comment.nvim
require("Comment").setup()
vim.keymap.set('i', "<C-_>", '<C-O>gcc', { remap = true })


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
vim.g.vimtex_quickfix_method = 'pplatex'
vim.g.vimtex_quickfix_open_on_warning = 0

-- require("neoscroll").setup()

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  shade_terminals = false,
})

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

-- map("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- vim.g.copilot_no_tab_map = true

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

-- nvim-ufl
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup({
  -- provider_selector = function(bufnr, filetype, buftype)
  -- provider_selector = function(_, _, _)
  --   return { 'treesitter', 'indent' }
  -- end
})

vim.g.oscyank_term = 'default'

-- https://github.com/sindrets/diffview.nvim
vim.keymap.set('n', '<leader>dv', '<CMD>DiffviewOpen<CR>', map_opts)
vim.keymap.set('n', '<leader>dh', '<CMD>DiffviewFileHistory<CR>', map_opts)
vim.keymap.set('n', '<leader>df', '<CMD>DiffviewFileHistory %<CR>', map_opts)

-- https://github.com/pwntester/octo.nvim#-examples
k('n', '<leader>Gi', '<CMD>Octo issue list<CR>', map_opts)
k('n', '<leader>Gp', '<CMD>Octo pr list<CR>', map_opts)
