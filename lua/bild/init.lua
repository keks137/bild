local M = {}

function M.build()
	print("buildy build")
	local term_buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_open_term(term_buf, {})

	vim.fn.termopen("make", {})

	--vim.cmd("split")
	--vim.api.nvim_set_current_buf(term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
