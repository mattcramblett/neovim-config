return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				auto_install = true,
				ensure_installed = { "lua_ls", "ts_ls", "solargraph", "kotlin_language_server", "tailwindcss" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.solargraph.setup({
				capabilities = capabilities,
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/solargraph.lua#L4
				settings = {
					solargraph = {
						diagnostics = false, -- using rubocop
            max_files = 0, -- unlimited
					},
				},
				init_options = { formatting = false },
			})

			lspconfig.kotlin_language_server.setup({
				capabilities = capabilities,
				filetypes = { "kotlin" },
				root_dir = require("lspconfig").util.root_pattern("gradlew", ".git"),
			})

			vim.keymap.set("n", "M", vim.diagnostic.open_float, { desc = "Diagnostics - open float window" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set(
				"n",
				"gI",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[G]oto [I]mplementation" }
			)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
		end,
	},
}
