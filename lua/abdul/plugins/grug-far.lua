return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      keymaps = {
        replace = { n = '<leader>r' },
        qflist = { n = '<leader>q' },
        syncLocations = { n = '<leader>s' },
        syncLine = { n = '<leader>l' },
        close = { n = '<leader>c' },
        historyOpen = { n = '<leader>t' },
        historyAdd = { n = '<leader>a' },
        refresh = { n = '<leader>f' },
        openLocation = { n = '<leader>o' },
        openNextLocation = { n = '<down>' },
        openPrevLocation = { n = '<up>' },
        gotoLocation = { n = '<enter>' },
        pickHistoryEntry = { n = '<enter>' },
        abort = { n = '<leader>b' },
        help = { n = 'g?' },
        toggleShowCommand = { n = '<leader>p' },
        swapEngine = { n = '<leader>e' },
        previewLocation = { n = '<leader>i' },
        swapReplacementInterpreter = { n = '<leader>x' },
      }
    });
  end
}
