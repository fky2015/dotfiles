if not vim.g.vscode then
	require("options")
	require("plugins")
	require("telescope_cfg")
	require("lsp")
	require("nvim-dap")
	require("statusline")
	require("theme")
	require("treesitter")
	require("other-plugins")
end
