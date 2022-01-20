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

vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("x", ";", ":", { noremap = true })

vim.api.nvim_set_keymap("n", ":", '<Plug>Lightspeed_;_ft' , { noremap = false })

-- Quicker way to open command window
vim.api.nvim_set_keymap("n", "q;", "q:", { noremap = true })

-- Quicker <Esc> in insert mode
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "jk", "<C-\\><C-n>", { noremap = true })

-- Quick Copy
vim.api.nvim_set_keymap("v", "<C-C>", '"+y', { noremap = true })

-- Edit config
local config_path = vim.fn.stdpath("config")
vim.api.nvim_set_keymap("n", "<leader>ec", ":vs<cr>:e " .. config_path .. "<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sc", ":source " .. config_path .. "<cr>", { noremap = true })

-- Copy all
vim.api.nvim_set_keymap("n", "<leader>ca", 'ggvG"+Y<c-o>', { noremap = true })

-- Force to learn new key binding
vim.api.nvim_set_keymap("i", "<ESC>", "<nop>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>pi", ":PackerInstall<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ps", ":PackerSync<CR>", { noremap = true })
