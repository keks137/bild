local M = {}

function M.build()
	vim.system({ "ls" }, { text = true })
	print("buildy build")
	local term_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_open_term(term_buf, {})

	vim.fn.termopen("make", {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				print("Command exited with code: " .. exit_code)
			end
		end,
	})

	vim.cmd("split")
	vim.api.nvim_set_current_buf(term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
