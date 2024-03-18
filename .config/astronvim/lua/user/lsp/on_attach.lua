return function(client, bufnr)
  if client.name == 'clangd' then
    local wk = require("which-key")

    wk.register({
      ["<LocalLeader>"] = {
        ["<LocalLeader>"] = {
          ":ClangdSwitchSourceHeader<CR>",
          "Switch between source and header",
        },
      },
    })
  end
  -- run some code when a language server attaches
end
