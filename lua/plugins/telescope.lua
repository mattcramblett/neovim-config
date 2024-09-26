return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>o", builtin.find_files, { desc = "Find files" }) -- search for file by name
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep" }) -- global text search
			vim.keymap.set("n", ",", builtin.buffers, { desc = "Telescope buffers" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
