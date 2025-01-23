local M = {}

function M.build()
	print("buildy build")
	--vim.cmd("new")

	local term_win = vim.api.nvim_create_buf(false, true)
	--vim.cmd("split")
	local term_wind = vim.api.nvim_open_win(term_win, true, {
		split = "below",
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
	local term_buf_win = vim.api.nvim_open_win(term_buf, true, {
		split = "right",
	})
	vim.api.nvim_win_close(term_buf_win, false)

	vim.api.nvim_set_current_buf(term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
