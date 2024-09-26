return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "onedark",
			},
			sections = {
				lualine_a = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 3,
						shorting_target = 42,
					},
				},
			},
		})
	end,
}
