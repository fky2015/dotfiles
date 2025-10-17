-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Basic
vim.keymap.set("n", "q;", "q:")
vim.keymap.set("n", "gl", "2g;")

vim.keymap.set("n", "\\", ":sp<CR>")
vim.keymap.set("n", "|", ":vs<CR>")

-- Copy
vim.keymap.set("n", "<C-C>", 'V"+y', { desc = "Quickly copy to system clipboard" })
vim.keymap.set("v", "<C-C>", '"+y', { desc = "Quickly copy to system clipboard" })
vim.keymap.set("n", "<leader>ca", 'ggvG"+Y<c-o>')

-- unimpaired blank_above/blank_below
vim.keymap.set("n", "[<Space>", function()
  local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
  local line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, repeated)
end, { desc = "Insert blank line above" })
vim.keymap.set("n", "]<Space>", function()
  local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
  local line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, line, line, true, repeated)
end, { desc = "Insert blank line below" })

Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ"):map("<leader>z")
