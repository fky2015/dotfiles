vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>Telescope treesitter<cr>")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<C-h>"] = "which_key",
			},
		},
	},
})

require("telescope").load_extension("emoji")

require("telescope").load_extension("fzf")
