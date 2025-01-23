local M = {}

function M.build()
	print("buildy build")
	--vim.cmd("new")
	vim.cmd("split")
	local term_buf = vim.api.nvim_create_buf(false, false)

	vim.cmd("split")
	vim.api.nvim_open_term(term_buf, {})

	vim.fn.termopen("make", {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				print("Command exited with code: " .. exit_code)
			end
		end,
	})

	vim.api.nvim_set_current_buf(term_buf)
	vim.cmd("buffer " .. term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
