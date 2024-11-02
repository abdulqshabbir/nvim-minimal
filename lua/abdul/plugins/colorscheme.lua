return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function(_, opts)
		require("kanagawa").setup({
      theme = "dragon",
      colors = {
        theme = {
          dragon = {
            ui = {
              bg_visual = "#581c87",
            },
            diff = {
              add = "#065f46",
              delete = "#be123c",
              change = "#92400e",
            }
          },
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
    }) -- Replace this with your favorite colorscheme
		vim.cmd("colorscheme kanagawa-dragon") -- Replace this with your favorite colorscheme
		-- Colorscheme overrides
		-- vim.cmd([[
		--       autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
		--       autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
		--       autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
		--       autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
	    	-- ]])
    -- Add custom highlights for Telescope matching selection
    vim.cmd("hi link TelescopeMatching IncSearch")

		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}

