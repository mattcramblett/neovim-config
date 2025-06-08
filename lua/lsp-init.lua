local servers = {
	"gopls",
	"kotlin_language_server",
	"lua_ls",
	"sorbet",
	"tailwindcss",
	"ts_ls",
	"vacuum",
	"ruby-lsp",
}

local servers_to_install = vim.tbl_filter(function(server)
	return server ~= "ruby-lsp"
end, servers)

local mason_lspconfig = require("mason-lspconfig")
-- auto install with mason-lspconfig
mason_lspconfig.setup({
	automatic_installation = true,
	ensure_installed = servers_to_install,
})

-- LSP keymaps
vim.keymap.set("n", "M", vim.diagnostic.open_float, { desc = "Diagnostics - open float window" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gr", function()
	require("telescope.builtin").lsp_references({
		prompt_title = "LSP References",
		path_display = { "shorten" },
	})
end, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, { desc = "[G]oto [I]mplementation" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })

vim.lsp.enable(servers)

-- Add LSP as a completion source
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
