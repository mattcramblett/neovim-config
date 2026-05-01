return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "javascript", "ruby", "typescript", "kotlin", "java", "rust", "zig" },
			auto_install = true,
		},
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = "InsertEnter",
	},
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
