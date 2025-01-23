local M = {}

function M.build()
	print("buildy build")
	local term_buf = vim.api.nvim_create_buf(false, true)
	local term_win = vim.api.nvim_open_win(term_buf, true, {
		relative = "editor",
		width = 80,
		height = 20,
		col = math.floor((vim.o.columns - 80) / 2),
		row = math.floor((vim.o.lines - 20) / 2),
		border = "rounded",
	})
	vim.api.nvim_open_term(term_buf, {})

	vim.fn.termopen("make", {})
	vim.api.nvim_set_option_value("winhighlight", "Normal:Normal", { scope = "local" })

	--vim.cmd("split")
	--vim.api.nvim_set_current_buf(term_buf)
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
