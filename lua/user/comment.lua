lvim.builtin.comment.post_hook = function(_)
	local r = unpack(vim.api.nvim_win_get_cursor(0))
	local rcnt = vim.api.nvim_buf_line_count(0)
	if rcnt > r then
		vim.api.nvim_win_set_cursor(0, { r + 1, 0 })
	end
end
