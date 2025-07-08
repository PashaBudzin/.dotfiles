return {
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			{
				"ray-x/lsp_signature.nvim",
				event = "VeryLazy",
				opts = {},
				config = function(_, opts)
					require("lsp_signature").setup(opts)
				end,
			},
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			{ "rcarriga/nvim-notify" },

			-- schemas
			{ "b0o/schemastore.nvim" },

			{ "stevearc/conform.nvim" },
		},
	},
}
