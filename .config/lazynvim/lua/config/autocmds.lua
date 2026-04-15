-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

-- Autoformat setting
-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "cpp", "sh" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value or {}
    if not value.kind then
      return
    end

    local status = value.kind == "end" and 0 or 1
    local percent = value.percentage or 0

    local osc_seq = string.format("\27]9;4;%d;%d\a", status, percent)

    if os.getenv("TMUX") then
      osc_seq = string.format("\27Ptmux;\27%s\27\\", osc_seq)
    end

    io.stdout:write(osc_seq)
    io.stdout:flush()
  end,
})
