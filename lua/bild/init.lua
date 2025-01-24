local M = {}
local build_command = 'make'

function M.set_build_command()
  build_command = 'ls'
end

function M.build()
  print 'buildy build'

  local term_win = vim.api.nvim_create_buf(false, true)
  local term_wind = vim.api.nvim_open_win(term_win, true, {
    split = 'below',
  })
  local term_buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_open_term(term_buf, {})

  vim.fn.termopen(build_command, {
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        print('Command exited with code: ' .. exit_code)
      end
    end,
  })
  local term_buf_win = vim.api.nvim_open_win(term_buf, true, {
    split = 'right',
  })
  vim.api.nvim_win_close(term_buf_win, false)
end

function M.setup()
  vim.api.nvim_create_user_command('Bild', M.build, {})
  vim.api.nvim_create_user_command('BildCommand', M.set_build_command, {})
end

return M
