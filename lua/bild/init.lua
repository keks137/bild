local M = {}

function M.build()
	local b = vim.system({ "ls" }, { text = true })
	print(b)
	print("buildy build")
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
