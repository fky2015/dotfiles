vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>Telescope help_tags<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>Telescope treesitter<cr>", { noremap = true })

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
