return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.9,
            preview_height = 0.5,
          },
        },
        ignore_patterns = { "node_modules", ".git", "yarn.lock", "package-lock.json" },
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-qf>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
            ["<C-qf"] = require("telescope.actions").smart_send_to_qflist
                + require("telescope.actions").open_qflist,
          },
          n = {
            ["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- telescope
    keymap.set("n", "<leader>p", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")                 -- list open buffers in current neovim instance
    keymap.set("n", "<leader>ft", "<cmd>Telescope help_tags<cr>")               -- list available help tags
    keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>")          -- find all references of variable
    keymap.set("n", "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>")
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>")     -- show diagnostics for current buffer
    keymap.set("n", "<leader>fD", "<cmd>Telescope diagnostics<cr>")             -- show diagnostics for all buffers
    keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- fuzzy find in current buffer

    -- git telescope
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>") -- search for git branches
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>") -- search for git commits
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_stash<CR>")  -- search for git stashes
  end,
}
