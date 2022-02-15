local gps = require("nvim-gps")
require("lualine").setup({
	extensions = { "nvim-tree", "fugitive", "quickfix" },
	sections = {
		lualine_c = { "filename", { gps.get_location, cond = gps.is_available } },
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "%3p%%/%L" },
	},
	options = {
		theme = "github",
	},
})
