local gps = require("nvim-gps")

-- TODO: change behavior of component `progress` and `location`, make them more useful.
require("lualine").setup({
    extensions = { "nvim-tree", 'fugitive', 'quickfix', },
    sections = { lualine_c = {'filename', { gps.get_location, cond = gps.is_available }},lualine_x = {'encoding', 'fileformat', 'filetype'}}
})
