-- NOTE: This file try to maintain a minimal configuration,
-- especially when open a lage file that you only want to do
-- some simple operations.
--
-- Assumed that only the following package are loaded:
-- (currently none)
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "number"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.timeoutlen = 300
vim.opt.backup = true
vim.opt.backup = true
vim.opt.backupdir = vim.env.HOME .. "/.cache/nvim/files/backup/"
vim.opt.backupext = "-nvimbackup"
vim.opt.backupskip = ""
vim.opt.undofile = true
vim.opt.undodir = vim.env.HOME .. "/.cache/nvim/files/undo/"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.cursorline = true
vim.opt.spelllang = "en_us,cjk"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
-- vim.opt.guifont = "FiraCode Nerd Font Mono:h20, MesloLGL NF:h20, Noto Sans Mono:h20"
vim.opt.guifont = "MesloLGS NF:h20"

vim.keymap.set("n", ";", ":")
vim.keymap.set("x", ";", ":")


-- Quicker way to open command window
vim.keymap.set("n", "q;", "q:")

-- Quicker <Esc> in insert mode
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>")

-- Quick Copy
vim.keymap.set("v", "<C-C>", '"+y')
vim.keymap.set("n", "<C-C>", 'V"+y')

-- Edit config
-- local config_path = vim.fn.stdpath("config")
-- vim.cmd({
-- 	[[
--   command! ConfigEdit :vs<cr>:e ]] .. config_path .. [[<cr>
--   command! ConfigLoad lua require('fky.utils').ReloadConfig()<CR>
-- ]],
-- })
-- vim.cmd("command! ConfigEdit :vs<cr>:e " .. config_path .. "<cr>")
-- vim.cmd("command! ConfigLoad lua require('fky.utils').ReloadConfig()<CR>")
-- vim.keymap.set("n", "<leader>ec", ":vs<cr>:e " .. config_path .. "<cr>", { noremap = true })
--
-- vim.keymap.set("n", "<leader>sc", "<Cmd>lua require('fky.utils').ReloadConfig()<CR>", { noremap = true })
--

vim.keymap.set("n", "gl", "2g;")

-- Copy all
vim.keymap.set("n", "<leader>ca", 'ggvG"+Y<c-o>')

-- Force to learn new key binding
vim.keymap.set("i", "<ESC>", "<nop>")
