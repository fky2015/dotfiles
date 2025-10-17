return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        tools = {
          claude = { cmd = { "ccr", "code" } },
        },
        mux = {
          enabled = true,
        },
      },
    },
    keys = function()
      return {
        -- nes is also useful in normal mode
        { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
        { "<leader>A", "", desc = "+ai", mode = { "n", "v" } },
        {
          "<leader>Aa",
          function()
            require("sidekick.cli").toggle()
          end,
          desc = "Sidekick Toggle CLI",
        },
        {
          "<leader>As",
          function()
            require("sidekick.cli").select()
          end,
          -- Or to select only installed tools:
          -- require("sidekick.cli").select({ filter = { installed = true } })
          desc = "Select CLI",
        },
        {
          "<leader>At",
          function()
            require("sidekick.cli").send({ msg = "{this}" })
          end,
          mode = { "x", "n" },
          desc = "Send This",
        },
        {
          "<leader>Av",
          function()
            require("sidekick.cli").send({ msg = "{selection}" })
          end,
          mode = { "x" },
          desc = "Send Visual Selection",
        },
        {
          "<leader>Ap",
          function()
            require("sidekick.cli").prompt()
          end,
          mode = { "n", "x" },
          desc = "Sidekick Select Prompt",
        },
        {
          "<c-.>",
          function()
            require("sidekick.cli").focus()
          end,
          mode = { "n", "x", "i", "t" },
          desc = "Sidekick Switch Focus",
        },
        -- Example of a keybinding to open Claude directly
        {
          "<leader>Ac",
          function()
            require("sidekick.cli").toggle({ name = "claude", focus = true })
          end,
          desc = "Sidekick Claude Toggle",
        },
      }
    end,
  },
}
