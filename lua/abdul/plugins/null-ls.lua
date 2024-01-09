return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters
		-- configure null_ls
		null_ls.setup({
			-- add package.json as identifier for root (for typescript monorepos)
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = {
				--  to disable file types use
				--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
				formatting.prettier, -- js/ts formatter
				formatting.stylua, -- lua formatter
				diagnostics.eslint_d.with({ -- js/ts linter
					condition = function(utils)
						return utils.root_has_file({
							".eslintrc.js",
							".eslintrc.cjs",
							".eslintrc",
							".eslintrc.json",
							"package.json",
						})
					end,
				}),
			},
			-- configure formatting command
			on_attach = function(current_client, bufnr)
				-- custom remaps
				local opts = { noremap = true, silent = true }
				local keymap = vim.keymap
				keymap.set("n", "<leader>F", function()
					vim.lsp.buf.format({
						bufnr = bufnr,
					})
				end, opts)
			end,
		})
	end,
}
