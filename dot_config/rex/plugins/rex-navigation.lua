local function navigate_on_host(ctx, args)
  -- The invoking server cannot open a socket on the pane's host.
  local host = rex.server(ctx.server)
  if not host.call("session.attach", { session_id = ctx.session_id }) then return false end
  local reply = host.call("client.action", {
    action = "navigate_window", origin = "api", args = args,
    session_id = ctx.session_id, block_id = ctx.block_id,
  })
  if not reply then return false end
  for _, action in ipairs(reply.client_actions or {}) do
    rex.client.queue(action.action, action.args)
  end
  return true
end

-- Switch Neovim windows first, then Rex panes at the edge.
rex.action{
  name = "navigate_window",
  title = "Navigate Editor Window or Pane",
  args = { key = "string" },
  repeats = true,
  run = function(ctx, args)
    local directions = { h = "left", j = "down", k = "up", l = "right" }
    local bytes = { h = "\008", j = "\010", k = "\011", l = "\012" }
    local direction = directions[args.key]
    if not direction then error("Expected h, j, k, or l", 0) end

    local terminal = "com.superlogical.terminal"
    local process = rex.block.call(terminal, "process", { block_id = ctx.block_id })
    local foreground = process and process.foreground
    local name = foreground and (foreground.name or foreground.path or "") or ""
    name = name:match("([^/]+)$") or name

    if name == "nvim" or name == "nvimdiff" then
      local remote = ctx.server and ctx.server ~= ""
      if remote and navigate_on_host(ctx, args) then return end

      local pid = foreground.pid
      local uid = foreground.user_id
      local path = not remote and pid and uid and ("/tmp/rex-nvim-" .. uid .. "/" .. pid)
      local file = path and io.open(path, "r")
      local socket
      local rpc_pid = pid
      if file then
        socket = file:read("*l")
        rpc_pid = tonumber(file:read("*l")) or pid
        file:close()
      end
      if socket and socket ~= "" then
        local expression = string.format('v:lua.rex_navigate_window("%s", %d)', args.key, rpc_pid)
        local result = rex.exec({ foreground.path or "nvim", "--server", socket,
          "--remote-expr", expression }, { timeout = 0.5 })
        local outcome = result and result.ok and result.stdout:match("^%s*(%a+)%s*$")
        if outcome == "moved" then return end
        if outcome == "edge" then
          rex.client.queue("pane.focus", { direction = direction, wrap = false })
          return
        end
      end
      -- Existing editors and prompts keep receiving their original control key.
      local _, err = rex.block.call(terminal, "write", { block_id = ctx.block_id, data = bytes[args.key] })
      if err then error(err, 0) end
      return
    end

    if name:match("^tmux") or name == "vim" or name == "vimdiff" or name == "view" or name == "ssh" then
      local _, err = rex.block.call(terminal, "write", { block_id = ctx.block_id, data = bytes[args.key] })
      if err then error(err, 0) end
      return
    end

    rex.client.queue("pane.focus", { direction = direction, wrap = false })
  end,
}

rex.bind("ctrl+h", "navigate_window", { key = "h" })
rex.bind("ctrl+j", "navigate_window", { key = "j" })
rex.bind("ctrl+k", "navigate_window", { key = "k" })
rex.bind("ctrl+l", "navigate_window", { key = "l" })
