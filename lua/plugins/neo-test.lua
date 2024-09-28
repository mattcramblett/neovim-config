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
    -- Keybinds
    vim.keymap.set("n", "<leader>t", neotest.run.run, { desc = "Run nearest [T]est" })

    vim.keymap.set("n", "T", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run [T]ests in current file" })

    vim.keymap.set("n", "dt", function()
      neotest.run.run({ strategy = "dap" })
    end, { desc = "[T]est - [D]ebug nearest" })

    vim.keymap.set("n", "ts", neotest.run.stop, { desc = "[T]est [S]top nearest" })
    vim.keymap.set("n", "ta", neotest.run.attach, { desc = "[T]est - [A]ttach to nearest" })
  end,
}
