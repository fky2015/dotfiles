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

-- Run line/selection in a dedicated shell.
local shell
local function run_in_shell(text)
  if text == "" then
    return
  end
  local ok, err = pcall(function()
    local chan = shell and shell:buf_valid() and vim.bo[shell.buf].channel or 0
    if chan == 0 or vim.fn.jobwait({ chan }, 0)[1] ~= -1 then
      if shell and shell:buf_valid() then
        shell:close()
      end
      shell = Snacks.terminal.open(nil, {
        count = 0, -- Keep this separate from ordinary Snacks terminals.
        start_insert = false,
        win = { enter = false, wo = { winbar = "Command shell" } },
      })
      chan = vim.bo[shell.buf].channel
      assert(chan > 0, "could not start the shell")
    else
      if shell:valid() and not shell:on_current_tab() then
        shell:hide()
      end
      shell:show()
    end
    vim.api.nvim_chan_send(chan, text .. "\n")
  end)
  if not ok then
    vim.notify("Command shell: " .. err, vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>t", function()
  run_in_shell(vim.api.nvim_get_current_line())
end, { desc = "Run line in shell" })

vim.keymap.set("x", "<leader>t", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  run_in_shell(table.concat(lines, "\n"))
end, { desc = "Run selection in shell" })

-- Add keymap for copy current file name
vim.keymap.set("n", "yp", function()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg("+", file_name)
end, { desc = "Copy current file name to clipboard" })
