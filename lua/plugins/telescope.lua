return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					fzf = {
						-- fuzzy = false, -- only exact matching
					},
				},
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            previewer = true,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
            },
          },
        },
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")

			vim.keymap.set("n", "<leader>o", builtin.find_files, { desc = "Find files" }) -- search for file by name
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep" }) -- global text search
			vim.keymap.set("n", ",", builtin.buffers, { desc = "Telescope buffers" })
		end,
	},
}
