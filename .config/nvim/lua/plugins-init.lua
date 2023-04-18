local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Properly load sqlite3.dll on Windows.
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.g.sqlite_clib_path = fn.stdpath("data") .. "\\sqlite3.dll"
end

local opts = {
  concurrency = 14
}

require("lazy").setup("plugins", opts)
