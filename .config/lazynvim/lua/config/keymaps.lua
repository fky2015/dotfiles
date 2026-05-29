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

-- Send line/selection to terminal
local function get_terminal_chan()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local chan = vim.b[buf].terminal_job_id
      if chan then
        return chan
      end
    end
  end
  return nil
end

vim.keymap.set("n", "<leader>t", function()
  local chan = get_terminal_chan()
  if not chan then
    Snacks.terminal.toggle()
    vim.defer_fn(function() end, 100)
    chan = get_terminal_chan()
  end
  if chan then
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_chan_send(chan, line .. "\n")
  end
end, { desc = "Send line to terminal" })

vim.keymap.set("v", "<leader>t", function()
  local chan = get_terminal_chan()
  if not chan then
    Snacks.terminal.toggle()
    vim.defer_fn(function() end, 100)
    chan = get_terminal_chan()
  end
  if chan then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
    local text = table.concat(lines, "\n")
    vim.api.nvim_chan_send(chan, text .. "\n")
  end
end, { desc = "Send selection to terminal" })
