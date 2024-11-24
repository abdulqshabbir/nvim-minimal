return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({})
    local api = require("supermaven-nvim.api")

    if not api.is_running() then
      api.start() -- starts supermaven-nvim
      api.use_free_version() -- switch to the free version
    end
  end
}
