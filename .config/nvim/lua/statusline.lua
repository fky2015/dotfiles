local lualine_theme_style = require('theme').lualine_theme_style

local ops = {
  theme = "auto"
}
if lualine_theme_style then
  ops.theme = lualine_theme_style
end

local navic = require("nvim-navic")
require("lualine").setup({
  extensions = { "nvim-tree", "fugitive", "quickfix" },
  sections = {
    lualine_c = { "filename",
      { function() return navic.get_location() end, cond = function() return navic.is_available() end } },
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "%3p%%/%L" },
  },
  options = ops,
})
