return {
  { "tpope/vim-fugitive" },
  { "dlyongemallo/diffview.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local on_attach = opts.on_attach

      opts.on_attach = function(buffer)
        if on_attach then
          on_attach(buffer)
        end

        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "]H", function()
          gs.nav_hunk("next", { target = "staged" })
        end, { buffer = buffer, desc = "Next Staged Hunk", silent = true })
        vim.keymap.set("n", "[H", function()
          gs.nav_hunk("prev", { target = "staged" })
        end, { buffer = buffer, desc = "Prev Staged Hunk", silent = true })
      end
    end,
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
}
