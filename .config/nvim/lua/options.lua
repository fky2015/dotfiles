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
vim.opt.termguicolors = true
vim.opt.guifont = "MesloLGS NF:h20"
vim.o.formatoptions = "jcroqlt"

vim.keymap.set("n", ";", ":")
vim.keymap.set("x", ";", ":")

vim.keymap.set("n", ":", ";")


-- Quicker way to open command window
vim.keymap.set("n", "q;", "q:")

-- TODO: only enable in simple-config-mode.
-- Quicker <Esc> in insert mode
-- vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>")

-- Quick Copy
vim.keymap.set("x", "<C-C>", '"+y')
vim.keymap.set("n", "<C-C>", 'V"+y')

vim.keymap.set("n", "gl", "2g;")

-- Copy all
vim.keymap.set("n", "<leader>ca", 'ggvG"+Y<c-o>')

-- Create new tab
vim.keymap.set("n", "<leader>T", ":tabnew %<CR>")

-- Force to learn new key binding
vim.keymap.set("i", "<ESC>", "<nop>")

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.cmd [[
      let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
        let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
        let &shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
  ]]
end
