return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "javascript", "ruby", "typescript", "kotlin", "java", "rust" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = "InsertEnter",
	},
}
