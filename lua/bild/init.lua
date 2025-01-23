local M = {}

function M.build()
	vim.system({ "ls" }, { text = true })
	print("buildy build")
	-- Create a new terminal buffer
	local term_buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
	vim.api.nvim_open_term(term_buf, {}) -- Open a terminal in the buffer

	-- Run the 'ls' command in the terminal
	vim.fn.termopen("make", {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				print("Command exited with code: " .. exit_code)
			end
		end,
	})

	-- Optionally, you can set the buffer to be displayed in a specific window
	vim.api.nvim_set_current_buf(term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
