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
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			local servers = {
				ruby_lsp = {
					-- https://shopify.github.io/ruby-lsp/editors.html#lazyvim-lsp
					mason = false,
					cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
				},
				ts_ls = {},
				kotlin_language_server = {
					filetypes = { "kotlin" },
					root_dir = require("lspconfig").util.root_pattern("gradlew", ".git"),
				},
				tailwindcss = {},
				zls = {},
			}

      -- Build list of servers to auto install
			local server_keys = vim.tbl_keys(servers)
			local install_list = vim.tbl_filter(function(key)
				return servers[key].mason == true or servers[key].mason == nil
			end, server_keys)
      -- setup and auto install the required servers
			mason_lspconfig.setup({
				auto_install = true,
				ensure_installed = install_list,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- setup ruby-lsp since it's not using Mason
      require("lspconfig").ruby_lsp.setup({
        capabilities = capabilities,
        settings = servers.ruby_lsp,
        filetypes = { "ruby" },
      })

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
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
