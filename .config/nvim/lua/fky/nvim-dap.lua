-- local dap_install = require("dap-install")
-- local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
local dap, dapui = require("dap"), require("dapui")

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed
  name = "lldb",
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = true,
  },
}

dap.configurations.c = dap.configurations.cpp

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

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local m = vim.keymap.set

m("v", "<M-k>", "<Cmd>lua require('dapui').eval()<CR>")
m("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>")
m("n", "<F7>", ":lua require'dap'.continue()<CR>")
m("n", "<F8>", ":lua require'dap'.step_over()<CR>")
m("n", "<F9>", ":lua require'dap'.step_into()<CR>")
m("n", "<F10>", ":lua require'dap'.step_out()<CR>")
m("n", "<leader>Dc", ":lua require'dap'.run_to_cursor()<CR>")
m("n", "<leader>DB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
m("n", "<leader>Db", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
m("n", "<leader>Dr", ":lua require'dap'.repl.toggle()<CR>")
m("n", "<leader>Dl", ":lua require'dap'.run_last()<CR>")
