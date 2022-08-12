vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>Telescope treesitter<cr>")

local trouble = require("trouble.providers.telescope")

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
        ["<C-h>"] = "which_key",
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble
      }
    },
  },
}

require("telescope").load_extension("emoji")

require("telescope").load_extension("fzf")
