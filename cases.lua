local function split(line)
	if type(line) ~= "string" then
		return nil
	end
end

return {
	split = split,
}
