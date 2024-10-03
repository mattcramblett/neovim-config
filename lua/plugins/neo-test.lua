return {
	"nvim-neotest/neotest",
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
				require("neotest-rspec"), -- https://github.com/olimorris/neotest-rspec?tab=readme-ov-file#wrench-configuration
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
      function() require("neotest").run.run() end,
      desc = "Run nearest [t]est"
    },
    {
      "<leader>T",
      function () require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Run all [T]ests in current file"
    },
    {
		  "<leader>td",
      function() require("neotest").run.run({ strategy = "dap" }) end,
      desc = "[T]est - [D]ebug nearest"
    },
    {
      "<leader>ts",
      function() require("neotest").run.stop() end,
      desc = "[T]est [S]top nearest"
    },
    {
      "<leader>ta",
      function () require("neotest").run.attach() end,
      desc = "[T]est - [A]ttach to nearest"
    },
    {
      "<leader>to",
      function() require("neotest").output.open({ enter = true, auto_close = true }) end,
      desc = "Show [T]est [O]utput"
    }
  },
}
