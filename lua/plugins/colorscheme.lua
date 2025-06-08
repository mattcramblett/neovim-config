return {
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")

			require("onedark").setup({
				style = "deep",
				colors = {
					-- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua#L88C10-L88C17
					bg0 = "#020a1a",
				},
			})

			require("onedark").load()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
}
