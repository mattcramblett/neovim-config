-- Formatter
return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true })
      end,
      mode = "n",
      desc = "[F]ormat [F]ile",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      ruby = { "rubocop" },
      kotlin = { "ktlint" },
      java = { "google-java-format" },
      rust = { "rustfmt", lsp_format = "fallback" },
      python = { "isort", "black" },
      typescript = {'prettier'},
      typescriptreact = {'prettier'},
      javascript = {'prettier'},
      javascriptreact = {'prettier'},
      json = {'prettier'},
      html = {'prettier'},
      css = {'prettier'},
      scss = {'prettier'},
      markdown = {'prettier'},
      yaml = {'prettier'},
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
