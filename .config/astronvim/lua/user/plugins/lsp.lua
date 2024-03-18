return {
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<F3>", "<cmd>AerialToggle!<CR>" },
    },
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
  },
}
