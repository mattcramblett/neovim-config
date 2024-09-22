-- unified LSP wrapper for diagnostics (linting) and formatting
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.prettier,
        diagnostics.rubocop,
        require("none-ls.diagnostics.eslint"),
        formatting.rubocop,
      },
    })

    vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
  end,
}
