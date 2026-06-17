return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "executable",
        command = "lldb",
      }
      -- dap.listeners.on_config["input-pick-process"] = function(config)
      --   local pid = config.pid
      --   if pid == "${command:pickClickHouseProcess}" then
      --     -- config.pid = require("dap.utils").pick_process({ filter = "clickhouse" })
      --     config.pid = require("dap.utils").pick_process()
      --   end
      --   return config
      -- end
    end,
  },
}
