-- vim.g.tokyonight_style = "storm"

local M = {}

-- Change this one: "github", "fox", "catppuccin"
local colorscheme = "catppuccin"

if colorscheme == "nightfox" then
  M.nightfox_theme_style = "nordfox"

  local palette = require("nightfox.palette").load(M.nightfox_theme_style)

  M.colors = {
    orange = palette.orange.base,
    error = palette.red.base,
    warning = palette.yellow.base,
    info = palette.blue.base,
    hint = palette.green.base,
    cyan = palette.cyan.base,
    bg_highlight = palette.bg1,
  }
  -- setup must be called before loading
  vim.cmd("colorscheme " .. M.nightfox_theme_style)
elseif colorscheme == "github" then
  -- Change this
  M.github_theme_style = "light_colorblind"
  M.lualine_theme_style = "github_" .. M.github_theme_style
  M.colors = require("github-theme").setup({
    theme_style = M.github_theme_style,
  })

  M.colors = require("github-theme.colors").setup({
    theme_style = M.github_theme_style,
  })
elseif colorscheme == "catppuccin" then
  local flavor = "frappe" -- latte, frappe, macchiato, mocha
  vim.g.catppuccin_flavour = flavor

  local palette = require("catppuccin.palettes").get_palette(flavor)

  require("catppuccin").setup({
    integrations = {
      aerial = true,
      lsp_trouble = true,
      dap = {
        enabled = true,
        enable_ui = false,
      },
      which_key = true,
      leap = true,
      nvimtree = true,
      notify = true,
      noice = true,
      octo = true,
      ts_rainbow2 = true,
      telescope = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      navic = {
        enabled = false,
        custom_bg = "NONE",
      },
      semantic_tokens = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    },
    color_overrides = {
      frappe = {
        -- default: #babbf1
        lavender = "#babbfc",
      },
      --   mocha = {
      --     text = "#F4CDE9",
      --     subtext1 = "#DEBAD4",
      --     subtext0 = "#C8A6BE",
      --     overlay2 = "#B293A8",
      --     overlay1 = "#9C7F92",
      --     overlay0 = "#866C7D",
      --     surface2 = "#705867",
      --     surface1 = "#5A4551",
      --     surface0 = "#44313B",
      --     base = "#352939",
      --     mantle = "#211924",
      --     crust = "#1a1016",
      --   },
    },
    -- color_overrides = {
    -- },
  })

  M.lualine_theme_style = "catppuccin"
  M.colors = {
    orange = palette.flamingo,
    error = palette.red,
    warning = palette.yellow,
    info = palette.blue,
    hint = palette.lavender,
    cyan = palette.sky,
    bg_highlight = palette.overlay0,
  }

  vim.cmd [[colorscheme catppuccin]]
end

M.colorscheme = colorscheme

return M
