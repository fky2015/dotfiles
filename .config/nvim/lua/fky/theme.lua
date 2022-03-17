-- vim.g.tokyonight_style = "storm"

local M = {}

-- Change this one: "github", "fox"
local colorscheme = "nightfox"

if colorscheme == "nightfox" then
	M.nightfox_theme_style = "nordfox"

	local pallet = require("nightfox.pallet").load(M.nightfox_theme_style)

	M.colors = {
		orange = pallet.orange.base,
		error = pallet.red.base,
		warning = pallet.yellow.base,
		info = pallet.blue.base,
		hint = pallet.green.base,
		cyan = pallet.cyan.base,
		bg_highlight = pallet.bg1,
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
end

M.colorscheme = colorscheme

return M
