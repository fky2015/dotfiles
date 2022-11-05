-- Include code auto-complete and code snippet settings.
-- For nvim-cmp
vim.opt.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local illuminate = require("illuminate")
local rt = require("rust-tools")

-- Helper function for luasnip.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
  }, {
    { name = "buffer" },
    { name = "path" },
    { name = "spell" },
    { name = "crates" },
    { name = "git" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true, -- do not show text alongside icons
      -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    }),
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Mapping diagnostic.
local opts = { silent = true }
vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.keymap.set("n", "<space>a", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- helper function for mappings
local m = function(mode, key, result)
  vim.keymap.set(mode, key, "<cmd> " .. result .. "<cr>", {
    buffer = 0,
    silent = true,
  })
end

local on_attach = function(client, bufnr)
  illuminate.on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  m("n", "gd", "lua vim.lsp.buf.definition()")
  m("n", "gy", "lua vim.lsp.buf.type_definition()")
  m("n", "gD", "lua vim.lsp.buf.declaration()")
  m("n", "K", "lua vim.lsp.buf.hover()")
  m("n", "gi", "lua vim.lsp.buf.implementation()")
  m("n", "<C-k>", "lua vim.lsp.buf.signature_help()")
  m("i", "<A-i>", "lua vim.lsp.buf.signature_help()")
  m("n", "<leader>wa", "lua vim.lsp.buf.add_workspace_folder()")
  m("n", "<leader>wr", "lua vim.lsp.buf.remove_workspace_folder()")
  m("n", "<leader>wl", "lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
  m("n", "<leader>rn", "lua vim.lsp.buf.rename()")
  m("n", "ga", "lua vim.lsp.buf.code_action()")
  m("n", "gr", "lua vim.lsp.buf.references()")
  m("n", "<C-L>", "lua vim.lsp.buf.format{ async = true }")
end

require("mason").setup {
  github = {
    -- The template URL to use when downloading assets from GitHub.
    -- The placeholders are the following (in order):
    -- 1. The repository (e.g. "rust-lang/rust-analyzer")
    -- 2. The release version (e.g. "v0.3.0")
    -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
    -- download_url_template = "https://download.fastgit.org/%s/releases/download/%s/%s",
  },
}
require("mason-lspconfig").setup {
  ensure_installed = { "rust_analyzer@nightly", "sumneko_lua" },
}

local lspconfig = require('lspconfig')
local setup_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup(setup_opts)
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["rust_analyzer"] = function()
    local extension_path = string.format(
      "%s/.vscode-oss/extensions/vadimcn.vscode-lldb-%s/",
      vim.env.HOME,
      "1.6.10"
    )
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    local rustopts = {
      server = vim.tbl_deep_extend("keep", {
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        on_attach = function(client, bufnr)
          illuminate.on_attach(client)

          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          m("n", "gd", "lua vim.lsp.buf.definition()")
          m("n", "gy", "lua vim.lsp.buf.type_definition()")
          m("n", "gD", "lua vim.lsp.buf.declaration()")
          -- m("n", "K", "lua vim.lsp.buf.hover()")
          m("n", "gi", "lua vim.lsp.buf.implementation()")
          m("n", "<C-k>", "lua vim.lsp.buf.signature_help()")
          m("i", "<A-i>", "lua vim.lsp.buf.signature_help()")
          m("n", "<leader>wa", "lua vim.lsp.buf.add_workspace_folder()")
          m("n", "<leader>wr", "lua vim.lsp.buf.remove_workspace_folder()")
          m("n", "<leader>wl", "lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
          m("n", "<leader>rn", "lua vim.lsp.buf.rename()")
          m("n", "ga", "lua vim.lsp.buf.code_action()")
          m("n", "gr", "lua vim.lsp.buf.references()")
          m("n", "<C-L>", "lua vim.lsp.buf.format{ async = true }")

          -- Hover actions
          vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          -- vim.keymap.set("n", "ga", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,

        settings = {

          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            inlayHints = {
              lifetimeElisionHints = {
                enable = true,
              },
              reborrowHints = {
                enable = true,
              }
            }
          }

        }
      }, setup_opts),
    }
    rt.setup(rustopts)
  end,
  ["sumneko_lua"] = function()
    local lua_opts = vim.tbl_deep_extend(
      "keep", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }, setup_opts
    )

    lspconfig.sumneko_lua.setup(lua_opts)
  end,
  ["clangd"] = function()
    setup_opts.capabilities.offsetEncoding = { 'utf-16' }
    lspconfig.clangd.setup(setup_opts)
  end
})


local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

-- null-ls.nvim

local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.diagnostics.shellcheck,
  -- null_ls.builtins.diagnostics.selene,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.formatting.latexindent,
  -- null_ls.builtins.code_actions.proselint,
  -- null_ls.builtins.diagnostics.proselint,
  -- null_ls.builtins.formatting.codespell,
}

null_ls.setup({ sources = sources })

require("fidget").setup({})
require("cmp_git").setup()

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
