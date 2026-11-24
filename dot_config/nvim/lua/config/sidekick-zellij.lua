local M = {}

function M.setup()
  local backend = require("sidekick.cli.session.zellij")
  if backend.sidekick_configured then
    return
  end
  backend.sidekick_configured = true
  local terminal = backend.terminal

  backend.terminal = function(self)
    local result = terminal(self)
    local config = require("sidekick.config").state("zellij-config-" .. self.sid .. ".kdl")
    -- Zellij 0.45 ignores the global --layout option in attach --create.
    -- Loading it as default_layout through the environment also works on attach.
    vim.fn.writefile({
      "default_layout " .. vim.json.encode(result.cmd[3]),
      'default_mode "locked"',
      'host_notification_protocol "osc9"',
      "session_serialization false",
      "show_startup_tips false",
      "show_release_notes false",
    }, config)
    result.env.ZELLIJ_CONFIG_FILE = config
    return result
  end
end

return M
