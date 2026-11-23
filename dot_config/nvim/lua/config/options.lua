-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Rex sessions have no system clipboard tool: clear 'clipboard' so Neovim's
-- built-in OSC 52 provider (requires an empty 'clipboard') handles "+y.
if vim.env.REX_SESSION and vim.env.REX_SESSION ~= "" then
  vim.opt.clipboard = ""
end

vim.g.maplocalleader = "-"

vim.opt.wrap = true

vim.g.lazyvim_picker = "snacks"

vim.lsp.log.set_level(vim.log.levels.OFF)
