return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = false,
      },
      cli = {
        tools = {
          coco = {
            cmd = { "coco" },
          },
        },
        mux = {
          enabled = true,
        },
      },
    },
  },
}
