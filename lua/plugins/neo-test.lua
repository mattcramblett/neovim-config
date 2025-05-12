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
    {
      "mattcramblett/neotest-gradle",
      -- dir = '~/code/neotest-gradle',
    }
	},
	opts = {
		status = { virtual_text = true },
		output = { open_on_run = true },
	},
	config = function(_, opts)
		opts.diagnostic = {
			enabled = true,
			severity = 1,
		}

		opts.discovery = {
			concurrent = 1, -- trying this to help with lag
			enabled = false,
			-- filter_dir = fun(name: string, rel_path: string, root: string): booleans
			--   A function to filter directories when searching for test files. Receives the name, path relative to project root and project root path
		}

		opts.status = {
			enabled = true,
			signs = true,
			virtual_text = true,
		}

		opts.adapters = {
			require("neotest-rspec")({
				-- May need to customize this by writing a function that ignores everything except the ./spec directory
				-- https://github.com/olimorris/neotest-rspec?tab=readme-ov-file#filtering-directories
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
			require("neotest-jest")({
				-- jestCommand = "jest --passWithNoTests",
				jestConfigFile = function(file)
					if string.find(file, "/apps/") then
						return string.match(file, "(.-/apps/[^/]+/)") .. "jest.config.js"
					end

					return vim.fn.getcwd() .. "/jest.config.js"
				end,
				cwd = function(file)
					if string.find(file, "/apps/") then
						return string.match(file, "(.-/apps/[^/]+/)")
					end
					return vim.fn.getcwd()
				end,
			}),
			-- require("codymikol/neotest-kotlin"),
      require("neotest-gradle"),
		}

		require("neotest").setup(opts)
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
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Show [T]est [O]utput Panel",
		},
		{
			"<leader>tts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "[T]est [T]oggle [S]ummary",
		},
	},
}
