local opts = { noremap = true, silent = true }
-- nvim-tree
vim.api.nvim_set_keymap("", "<F2>", ":NvimTreeToggle<CR>", opts)
-- nnoremap <leader>r :NvimTreeRefresh<CR>
-- nnoremap <leader>n :NvimTreeFindFile<CR>
--
-- SymbolsOutline
vim.api.nvim_set_keymap("", "<F3>", ":SymbolsOutline<CR>", opts)

vim.api.nvim_set_keymap("n", "<F4>", '<CMD>lua require("FTerm").toggle()<CR>', opts)
vim.api.nvim_set_keymap("t", "<F4>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- require("nvim-tree").setup({
-- view = {
-- auto_resize = true,
-- -- }
-- open_on_setup = true,
-- })

-- animate.vim
vim.api.nvim_set_keymap("n", "<Up>", ":call animate#window_delta_height(10)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", ":call animate#window_delta_height(-10)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", ":call animate#window_delta_width(10)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", ":call animate#window_delta_width(-10)<CR>", { noremap = true, silent = true })

-- numToStr/Comment.nvim
require("Comment").setup()

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
})

--- Git Relative

-- gitsigns.nvim
require("gitsigns").setup()

vim.g.indent_blankline_filetype_exclude = { "alpha" }

require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
})

vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.tex_flavor = "latex"

require("neoscroll").setup()

-- require("startup").setup({ theme = "dashboard" })

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	shade_terminals = false,
})

-- if you use `<CR>` as toggle, then you should handle when to fallback yourself so it won't intercept the plain-old `<CR>`.
vim.api.nvim_set_keymap("n", "<leader>z", ":NeoZoomToggle<CR>", { noremap = true, silent = true, nowait = true })

-- barbar.nvim
local map = vim.api.nvim_set_keymap
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
