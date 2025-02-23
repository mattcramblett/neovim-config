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
						theme = "ivy",
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
						theme = "ivy",
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
			require("config.telescope.multigrep").setup()

			vim.keymap.set("n", "<leader>o", builtin.find_files, { desc = "Find files" }) -- search for file by name
			vim.keymap.set(
				"n",
				"<leader>?",
				":!open https://regex101.com<CR><CR>",
				{ desc = "Open regex101 for help!" }
			)
			vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Search [H]elp" }) -- search help docs

			vim.keymap.set("n", ",", builtin.buffers, { desc = "Telescope buffers" })

			-- Quickfix
			vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "qfix next" })
			vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "qfix prev" })
			vim.keymap.set("n", "<M-c>", "<cmd>cclose<CR>", { desc = "qfix close" })
			vim.keymap.set("n", "<M-o>", "<cmd>copen<CR>", { desc = "qfix open" })
			-- :cdo s/find/replace/gc will find and replace over every item in the quickfix list

			-- Quick searches
			vim.keymap.set("n", "gs", 'yiw/<c-r>"<cr>', { desc = "[G]o to [S]earch within current file" })
			vim.keymap.set("n", "gS", builtin.grep_string, { desc = "[G]o to [S]earch" })
			vim.keymap.set("n", "go", function()
				builtin.find_files({ default_text = vim.fn.expand("<cword>") })
			end, { desc = "[G]o to [O]pen file (search files with word)" })
		end,
	},
	{
		"axkirillov/easypick.nvim",
		config = function()
      -- Setup pickers with arbitray commands
			local get_default_branch = "git remote show origin | grep 'HEAD branch' | cut -d' ' -f5"
			local base_branch = vim.fn.system(get_default_branch) or "main"
			local easypick = require("easypick")
			easypick.setup({
        pickers = {
          -- diff current branch with base_branch and show files that changed with respective diffs in preview
          {
            name = "branch_changes",
            command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
            previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
          },
        }
			})

			vim.keymap.set(
				"n",
				"<leader>gd",
				"<cmd>:Easypick branch_changes<CR>",
				{ desc = "[G]it [D]iff changes on this branch" }
			)
		end,
	},
}
