return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>hm",
			"<cmd>lua require('harpoon.mark').add_file()<cr>",
			{ desc = "Mark file with harpoon" }
		)
		keymap.set(
			"n",
			"<leader>hui",
			"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
			{ desc = "Go to previous harpoon mark" }
		)
		keymap.set("n", ";a", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Go to first file" })
		keymap.set("n", ";s", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Go to second file" })
		keymap.set("n", ";d", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Go to third file" })
		keymap.set("n", ";f", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Go to fourth file" })
	end,
}
