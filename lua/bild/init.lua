local M = {}

function M.build()
	print("buildy build")
	vim.cmd("new")

	local term_win = vim.api.nvim_create_buf(false, true)
	--vim.cmd("split")
	local term_wind = vim.api.nvim_open_win(term_win, true, {
		relative = "editor",
		width = 80,
		height = 20,
		col = (vim.o.columns - 80) / 2,
		row = (vim.o.lines - 20) / 2,
		border = "rounded", -- You can change the border style
	})
	local term_buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_open_term(term_buf, {})

	vim.fn.termopen("make", {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				print("Command exited with code: " .. exit_code)
			end
		end,
	})

	vim.api.nvim_set_current_buf(term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
