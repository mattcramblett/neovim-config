return {
  "shortcuts/no-neck-pain.nvim",
  config = function ()
    require("no-neck-pain").setup({
      width = 150,
    })
    vim.keymap.set("n", "<leader>nn", "<CMD>NoNeckPain<CR>", { desc = "No neck pain mode" })
  end
}

