local M = {}

function M.build()
	vim.system({ "ls" }, { text = true })
	print("buildy build")
	-- Execute the 'ls' command
	local handle = io.popen("make") -- You can customize the command here
	local result = handle:read("*a") -- Read the output

	if result == nil then
		print("whoopsie")
	end
	handle:close()

	if handle == nil then
		print("whoopsie")
	end
	-- Create a new buffer and set it to display the output
	local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n")) -- Set the buffer lines

	-- Open a new window with the buffer
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 80,
		height = 20,
		col = 10,
		row = 5,
		border = "rounded",
	})
end

function M.setup()
	vim.api.nvim_create_user_command("Bild", M.build, {})
end

return M
