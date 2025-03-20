return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      {
        "<Left>",
        function()
          require("smart-splits").resize_left(10)
        end,
      },
      {
        "<Right>",
        function()
          require("smart-splits").resize_right(10)
        end,
      },
      {
        "<Up>",
        function()
          require("smart-splits").resize_up(10)
        end,
      },
      {
        "<Down>",
        function()
          require("smart-splits").resize_down(10)
        end,
      },
    },
  },
}
