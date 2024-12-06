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
						case_mode = "ignore_case", -- "smart_case", "ignore_case" or "respect_case"
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
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						-- `-i` for case-insensitive
						-- `-F` == `--fixed-strings`, meaning no regex and literal strings
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!**/.git/*",
							"--glob",
							"!*.rbi",
							"-i",
							"-F",
						},
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")

			-- args to pass to ripgrep
			-- https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#common-options

			vim.keymap.set("n", "<leader>o", builtin.find_files, { desc = "Find files" }) -- search for file by name
			vim.keymap.set("n", "<leader>/", function()
				-- fixed-strings: Disable regular expression matching and treat the pattern as a literal string.
				builtin.live_grep({ additional_args = { "--ignore-case", "--fixed-strings", "--glob", "!*.rbi" } })
			end, { desc = "Live grep (words)" })

			vim.keymap.set("n", "<leader>s", function()
				builtin.live_grep({ additional_args = { "--glob", "!*.rbi" } })
			end, { desc = "Live grep (regex)" })
			vim.keymap.set(
				"n",
				"<leader>?",
				":!open https://regex101.com<CR><CR>",
				{ desc = "Open regex101 for help!" }
			)

			vim.keymap.set("n", ",", builtin.buffers, { desc = "Telescope buffers" })

			-- Quick searches
			vim.keymap.set("n", "gs", 'yiw/<c-r>"<cr>', { desc = "[G]o to [S]earch within current file" })
			vim.keymap.set("n", "gS", builtin.grep_string, { desc = "[G]o to [S]earch" })
			vim.keymap.set("n", "go", function()
				builtin.find_files({ default_text = vim.fn.expand("<cword>") })
			end, { desc = "[G]o to [O]pen file (search files with word)" })
		end,
	},
}
