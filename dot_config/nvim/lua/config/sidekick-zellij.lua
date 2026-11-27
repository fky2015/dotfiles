local M = {}

function M.toggle(name)
  name = name or "traex"
  local State = require("sidekick.cli.state")
  if #State.get({ name = name, cwd = true, attached = true }) > 0 then
    require("sidekick.cli").toggle({ name = name, filter = { cwd = true } })
    return
  end

  -- Zellij's stable session name is derived from the tool and cwd.
  -- attach --create handles both reusing and creating that session.
  require("sidekick.cli.session").setup()
  State.attach({ tool = require("sidekick.config").get_tool(name) }, { show = true })
end

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
