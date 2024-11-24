return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    -- lsp zero setup
    local lsp_zero = require("lsp-zero")
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })

      -- custom remaps
      local opts = { noremap = true, silent = true }
      local keymap = vim.keymap

      -- rename keys
      opts.buffer = bufnr
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      -- most important
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      -- see code actions
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      -- diagnostic remaps
      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>yy", vim.diagnostic.open_float, opts) -- show diagnostics for line
      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "yp", vim.diagnostic.goto_prev, opts)          -- jump to previous diagnostic in buffer
      opts.desc = "Go to next diagnostic"
      keymap.set("n", "<leader>n", vim.diagnostic.goto_next, opts)   -- jump to next diagnostic in buffer

      -- documentation
      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      -- restart lsp
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

      -- Change the Diagnostic symbols in the gutter
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- remove unused imports
      local function remove_unused_imports()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.removeUnusedImports.ts" },
            diagnostics = {},
          },
        })
      end

      keymap.set("n", "<leader>r", remove_unused_imports, { desc = "Remove unused imports" })
    end)
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "lua_ls",
        "eslint",
        "tailwindcss",
        "ts_ls",
        "graphql",
        "emmet_ls",
        "lua_ls",
      },
      handlers = {
        lsp_zero.default_setup,
      },
    })

    -- custom setup for language servers
    -- local lspconfig = require("lspconfig")
    -- lspconfig.lua_ls.setup({})

    -- auto completion
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- Scroll up and down in the completion documentation
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "luasnip" }, -- For luasnip users.
        { name = "nvim_lsp" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
