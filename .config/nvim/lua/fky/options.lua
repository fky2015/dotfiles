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
vim.opt.spelllang = "en_us"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.guifont = "FiraCode Nerd Font Mono, MesloLGL Nerd Font Mono, Noto Sans Mono"

vim.keymap.set("n", ";", ":")
vim.keymap.set("x", ";", ":")

vim.keymap.set("n", ":", "<Plug>Lightspeed_;_ft", { noremap = false })

-- Quicker way to open command window
vim.keymap.set("n", "q;", "q:")

-- Quicker <Esc> in insert mode
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>")

-- Quick Copy
vim.keymap.set("v", "<C-C>", '"+y')

-- Edit config
local config_path = vim.fn.stdpath("config")
-- vim.cmd({
-- 	[[
--   command! ConfigEdit :vs<cr>:e ]] .. config_path .. [[<cr>
--   command! ConfigLoad lua require('fky.utils').ReloadConfig()<CR>
-- ]],
-- })
vim.cmd("command! ConfigEdit :vs<cr>:e " .. config_path .. "<cr>")
vim.cmd("command! ConfigLoad lua require('fky.utils').ReloadConfig()<CR>")
-- vim.keymap.set("n", "<leader>ec", ":vs<cr>:e " .. config_path .. "<cr>", { noremap = true })
--
-- vim.keymap.set("n", "<leader>sc", "<Cmd>lua require('fky.utils').ReloadConfig()<CR>", { noremap = true })

-- Copy all
vim.keymap.set("n", "<leader>ca", 'ggvG"+Y<c-o>')

-- Force to learn new key binding
vim.keymap.set("i", "<ESC>", "<nop>")

vim.keymap.set("n", "<leader>pi", ":PackerInstall<CR>")
vim.keymap.set("n", "<leader>ps", ":PackerSync<CR>")
vim.keymap.set("n", "<leader>pc", ":PackerCompile<CR>")

vim.keymap.set("n", "<localleader>f", ":lua require('fky.utils').FoldColumnToggle()<CR>")
vim.keymap.set("n", "<leader>q", ":QFToggle!<CR>")
vim.keymap.set("n", "<leader>l", ":LLToggle!<CR>")
