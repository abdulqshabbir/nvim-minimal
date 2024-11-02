return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
      }
    })

		local keymap = vim.keymap -- for conciseness
		keymap.set(
			"n",
			"<leader>ts",
			"<cmd>Neotest<CR>",
			{ desc = "Neotest summary" }
		)
  end,
}
