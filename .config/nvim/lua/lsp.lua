-- Include code auto-complete and code snippet settings.
-- For nvim-cmp
vim.opt.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local illuminate = require("illuminate")
local lsp_status = require("lsp-status")

-- Helper function for luasnip.
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
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
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "spell" },
		{ name = "crates" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			with_text = true, -- do not show text alongside icons
			-- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		}),
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- helper function for mappings
local m = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd> " .. result .. "<cr>", {
		noremap = true,
		silent = true,
	})
end

local on_attach = function(client)
	illuminate.on_attach(client)

	lsp_status.on_attach(client)
	lsp_status.register_progress()

	-- Mappings.
	m("n", "ga", "lua vim.lsp.buf.code_action()")
	m("n", "gD", "lua vim.lsp.buf.declaration()")
	m("n", "gd", "lua vim.lsp.buf.definition()")
	m("n", "ge", "lua vim.lsp.diagnostic.goto_next()")
	m("n", "gE", "lua vim.lsp.diagnostic.goto_prev()")
	m("n", "gi", "lua vim.lsp.buf.implementation()")
	m("n", "gr", "lua vim.lsp.buf.references()")
	m("n", "K", "lua vim.lsp.buf.hover()")
	m("n", "gl", "lua vim.lsp.diagnostic.show_line_diagnostics()")
	m("n", "<space>rn", "lua vim.lsp.buf.rename()")
	m("n", "<C-L>", "lua vim.lsp.buf.formatting()")
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end
	if server.name == "rust_analyzer" then
		local extension_path = string.format(
			"%s/.vscode-oss/extensions/vadimcn.vscode-lldb-%s/",
			vim.env.HOME,
			"1.6.10"
		)
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
		local rustopts = {
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},

				settings = {
					["rust-analyzer"] = {
						-- completion = {
						--     postfix = {
						--         enable = false
						--     }
						-- },
						-- checkOnSave = {
						--     command = "clippy"
						-- },
					},
				},
			}),
		}
		require("rust-tools").setup(rustopts)
		server:attach_buffers()
		return
	elseif server.name == "sumneko_lua" then
		opts.commands = {
			Format = {
				function()
					require("stylua-nvim").format_file()
				end,
			},
		}
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

require("luasnip/loaders/from_vscode").lazy_load()

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

-- null-ls.nvim

local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.formatting.stylua,
}

null_ls.setup({ sources = sources })

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
