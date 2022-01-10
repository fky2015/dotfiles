-- nvim-tree
vim.api.nvim_set_keymap('', '<F2>', ':NvimTreeToggle<CR>', { noremap = true })
-- nnoremap <leader>r :NvimTreeRefresh<CR>
-- nnoremap <leader>n :NvimTreeFindFile<CR>

-- require'nvim-tree'.setup {
--   view = {
--     width = 30,
--     auto_resize = true,
--   }
-- -- open_on_setup = true,
-- }

-- animate.vim
vim.api.nvim_set_keymap('n', '<Up>', ':call animate#window_delta_height(10)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', ':call animate#window_delta_height(-10)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', ':call animate#window_delta_width(10)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', ':call animate#window_delta_width(-10)<CR>', { noremap = true, silent = true })

-- numToStr/Comment.nvim
require('Comment').setup()

require('nvim-autopairs').setup(
{
disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
  }
)

--- Git Relative

-- gitsigns.nvim
require('gitsigns').setup()

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

vim.g.vimtex_compiler_progname = 'nvr'
vim.g.vimtex_view_method = 'zathura'
vim.g.tex_flavor = 'latex'

require('neoscroll').setup()

require"startup".setup({theme = "evil"})

local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
    handle = {
        color = colors.bg_highlight,
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
})

require("toggleterm").setup{
  open_mapping = [[<c-\>]],
}
