local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

-- require('dapui').setup(
--   {
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     -- Use a table to apply multiple mappings
--     expand = { "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--   },
--   sidebar = {
--     -- You can change the order of elements in the sidebar
--     elements = {
--       -- Provide as ID strings or tables with "id" and "size" keys
--       {
--         id = "scopes",
--         size = 0.25, -- Can be float or integer > 1
--       },
--       { id = "breakpoints", size = 0.25 },
--       { id = "stacks", size = 0.25 },
--       { id = "watches", size = 00.25 },
--     },
--     size = 40,
--     position = "left", -- Can be "left", "right", "top", "bottom"
--   },
--   tray = {
--     elements = { "repl" },
--     size = 10,
--     position = "bottom", -- Can be "left", "right", "top", "bottom"
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil, -- Floats will be treated as percentage of your screen.
--     border = "single", -- Border style. Can be "single", "double" or "rounded"
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
-- }
-- )

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local m = vim.api.nvim_set_keymap
local opts = { noremap = true }

m("v", "<M-k>", "<Cmd>lua require('dapui').eval()<CR>", opts)
m("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
m("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
m("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
m("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
m("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
m("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
m(
	"n",
	"<leader>lp",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	opts
)
m("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opts)
m("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", opts)
