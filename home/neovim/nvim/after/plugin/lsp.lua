local lsp_zero = require("lsp-zero")
local conform = require("conform")

local prettier = { "prettierd", "prettier" }

conform.setup({
	lsp_fallback = true,
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = prettier,
		typescript = prettier,
		javascriptreact = prettier,
		typescriptreact = prettier,
		vue = prettier,
		json = prettier,
		svelte = prettier,
		html = prettier,
		css = prettier,
		scss = prettier,
		less = prettier,
		astro = prettier,
		go = { "goimports", "gofmt" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
		nix = { "nixfmt" },
	},
	formatters = {
		prettier = {
			args = function(_, ctx)
				if vim.endswith(ctx.filename, ".astro") then
					return {
						"--stdin-filepath",
						"$FILENAME",
						"--plugin",
						"prettier-plugin-astro",
						"--plugin",
						"prettier-plugin-tailwindcss",
					}
				end
				return { "--stdin-filepath", "$FILENAME", "--plugin", "prettier-plugin-tailwindcss" }
			end,
		},
	},

	default_format_opts = {
		stop_after_first = true,
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>e", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		require("conform").format({ async = true, lsp_fallback = true })
	end, { desc = "Format current buffer with LSP" })

	vim.keymap.set("n", "<leader>i", vim.cmd.Format)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls", "jsonls", "yamlls", "eslint" },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

require("lspconfig").lua_ls.setup({
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

vim.g.rustaceanvim = {
	server = {
		capabilities = lsp_zero.get_capabilities(),
		default_settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = false,
				},
			},
		},
	},
}

-- require("lspconfig").rust_analyzer.setup({
-- 	settings = {
-- 		["rust-analyzer"] = {
-- 			diagnostics = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

require("lspconfig").ts_ls.setup({})
require("lspconfig").clangd.setup({})

-- require("lspconfig").nil_ls.setup({})

require("lspconfig").nixd.setup({
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.nixos.options',
				},
				home_manager = {
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.pasha.options',
				},
			},
		},
	},
})

require("lspconfig").gopls.setup({})

require("lspconfig").jsonls.setup({
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			-- Schemas
			schemas = require("schemastore").json.schemas(),
		},
	},
})

require("lspconfig")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<c-space>"] = cmp.mapping.complete(),
		["<tab>"] = cmp.mapping.confirm({ select = true }),
	}),
})
