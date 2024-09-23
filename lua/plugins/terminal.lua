return {
	"voldikss/vim-floaterm",
	config = function()
		require("floaterm").setup({
			width = 0.9,
			height = 0.9,
		})
	end,
}
