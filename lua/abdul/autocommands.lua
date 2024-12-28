-- Reference: http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
local group = vim.api.nvim_create_augroup("VCenterCursor", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufEnter", "WinEnter", "WinNew", "VimResized" },
  {
    group = group,
    pattern = { "*", "*.*" },
    command = "let &scrolloff=(winheight(win_getid())/2) + 1",
  }
)


-- text highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})


-- fugitive diff highlights
local api = vim.api
local override = 'DiffAddAsDelete'
function fix_highlight()
  local nr = api.nvim_win_get_buf(0)
  local name = api.nvim_buf_get_name(nr)
  local winhl = vim.wo.winhl

  if not vim.wo.diff or winhl:match(override) then
    return
  end

  if winhl == '' then
    vim.wo.winhl = 'DiffAdd:' .. override
  else
    vim.wo.winhl = winhl .. ',DiffAdd:' .. override
  end
end

vim.cmd('autocmd ColorScheme * hi DiffAddAsDelete guibg=#f2e3cd')
vim.cmd('hi StatusLine guibg=NONE')
vim.cmd('autocmd BufNew fugitive://* lua fix_highlight()')
