return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-rspec",
		"nvim-neotest/neotest-jest",
		"codymikol/neotest-kotlin",
	},
	opts = {
		status = { virtual_text = true },
		output = { open_on_run = true },
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-rspec")({
					filter_dirs = { ".git", "node_modules", "sorbet", "client", "client_monorepo", "db", "script", "log" },
					-- Optionally your function can take a position_type which is one of:
					-- - "file"
					-- - "test"
					-- - "dir"
					rspec_cmd = function(position_type)
						-- ensure generated tests (ex: .each loops with an example) will fail past the first iteration if needed.
						-- only do this when running an individual test because otherwise the whole file fails if one example fails.
						if position_type == "test" then
							return vim.tbl_flatten({
								"bundle",
								"exec",
								"rspec",
								"--fail-fast",
							})
						else
							return vim.tbl_flatten({
								"bundle",
								"exec",
								"rspec",
							})
						end
					end,
				}),
				require("neotest-jest")({ -- https://github.com/nvim-neotest/neotest-jest?tab=readme-ov-file#monorepos
					jestCommand = "yarn test --",
					jestConfigFile = "jest.config.ts",
					env = { CI = true },
					cwd = function(_path)
						return vim.fn.getcwd()
					end,
				}),
				-- require("codymikol/neotest-kotlin"),
			},
		})
	end,
	keys = {
		{
			"<leader>t",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest [t]est",
		},
		{
			"<leader>T",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run all [T]ests in current file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "[T]est - [D]ebug nearest",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "[T]est [S]top nearest",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "[T]est - [A]ttach to nearest",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show [T]est [O]utput",
		},
	},
}
