return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"solargraph",
				},
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

      local util = require("lspconfig.util")
			lspconfig.solargraph.setup({
				capabilities = capabilities,
				settings = {
					Solargraph = {
						max_files = 25000,
            root_dir = util.root_pattern("Gemfile", ".git")(fname) or util.path.dirname(vim.api.nvim_buf_get_name(0)),
            exclude = { "client/**/*", "**/*.rbi" }
					},
				},
			})

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
