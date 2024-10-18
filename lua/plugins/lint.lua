return {
	"mfussenegger/nvim-lint",
	config = function()
		-- Linters by filetype
		require("lint").linters_by_ft = {
			ruby = { "rubocop" },
			kotlin = { "ktlint" },
			typescript = { "eslint" },
			javascript = { "eslint" },
			typescriptreact = { "eslint" },
			javascriptreact = { "eslint" },
			html = { "htmlhint" },
			css = { "stylelint" },
			scss = { "stylelint" },
			json = { "jsonlint" },
			markdown = { "vale" },
			python = { "pylint" },
			zsh = { "zsh" },
			sql = { "sqlfluff" },
		}

		local rubocop = require("lint").linters.rubocop
		rubocop.args = {
			"--require",
			"rubocop-rspec",
		}
		-- Run linting on save
		vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end,
}
