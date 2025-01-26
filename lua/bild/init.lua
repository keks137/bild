local M = {}
local build_command = 'make'
local Command_Window_Id = nil
local Command_Window_Buffer = nil

function M.set_build_command(args)
  build_command = args[1]
end

function M.close_setter_buffer()
  if Command_Window_Id ~= nil and Command_Window_Buffer ~= nil then
    local lines = vim.api.nvim_buf_get_lines(Command_Window_Buffer, 0, -1, false)

    build_command = ''
    for _, line in ipairs(lines) do
      build_command = build_command .. line
    end
    print(build_command)
    vim.api.nvim_win_close(Command_Window_Id, false)
  end
end

function M.create_command_buffer() -- Create a new buffer (no file name, it's an empty buffer)
  Command_Window_Buffer = vim.api.nvim_create_buf(false, true)

  -- Set the buffer's contents (optional)
  vim.api.nvim_buf_set_lines(Command_Window_Buffer, 0, -1, false, { build_command })

  -- Open the buffer in a new window with specified dimensions (e.g., 10 lines, 30 columns)
  local width = 30
  local height = 10
  local row = math.floor((vim.o.lines - height) / 2) -- center vertically
  local col = math.floor((vim.o.columns - width) / 2) -- center horizontally

  local opts = {
    relative = 'editor', -- position relative to the editor
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal', -- minimal window style (no borders)
    bufpos = { 0, 0 }, -- position to open the buffer from the top-left
  }
  -- Open the buffer in a new floating window
  Command_Window_Id = vim.api.nvim_open_win(Command_Window_Buffer, true, opts)
  print(Command_Window_Id)
  vim.keymap.set('n', '<Esc>', function()
    M.close_setter_buffer()
  end, { buffer = Command_Window_Buffer, silent = true })
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
  vim.cmd 'startinsert'
end

function M.setup()
  vim.api.nvim_create_user_command('Bild', M.build, {})
  vim.api.nvim_create_user_command('BildCommandBuffer', M.create_command_buffer, {})
  vim.api.nvim_create_user_command('BildCommand', function(opts)
    -- `opts.fargs` is an array of arguments passed to the command
    M.set_build_command(opts.fargs)
  end, {
    -- Define the command to accept one or more arguments
    nargs = '?', -- '?' means the argument is optional
  })
end

return M
