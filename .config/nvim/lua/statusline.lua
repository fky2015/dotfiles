local gps = require("nvim-gps")
local lsp_status = require("lsp-status")

local lsp_progress = function()
	return require("lsp-status").status()
end

require("lualine").setup({
	extensions = { "nvim-tree", "fugitive", "quickfix" },
	sections = {
		lualine_c = { "filename", { gps.get_location, cond = gps.is_available } },
		lualine_x = { lsp_progress, "encoding", "fileformat", "filetype" },
		lualine_y = { "%3p%%/%L" },
	},
	options = {
		theme = "github",
	},
})

lsp_status.config({
	current_function = false,
	show_filename = false,
	diagnostics = false,
	status_symbol = "",
})
