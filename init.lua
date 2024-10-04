local function diw()
	local cword = vim.call("expand", "<cword>")
	local cline = vim.api.nvim_get_current_line()
	local wbegin, wend = string.find(cline, cword)

	if wbegin == nil or wend == nil then
		print("not in word")
		return
	end

	local upper_inword_idx = string.find(cword, "(%u)")
	if upper_inword_idx == nil then
		local newline = string.gsub(cline, cword, "")
		vim.api.nvim_set_current_line(newline)
		return
	end

	local delete = string.sub(cword, 1, upper_inword_idx - 1)
	local newword = string.gsub(cword, delete, "")
	newword = newword:sub(1, 1):lower() .. newword:sub(2)
	local newline = string.gsub(cline, cword, newword)
	vim.api.nvim_set_current_line(newline)

	local zhopaPerdezhHui = 0
end

local function w()
	local iw = vim.call("expand", "<cword>")

	local _, posx = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
	local cline = vim.api.nvim_get_current_line()
	local wpos = cline:find(iw)
	if posx < wpos then
		return iw
	end
end

return {
	diw = diw,
}
