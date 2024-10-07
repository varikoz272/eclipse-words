local function get_replaced_at(str, id)
	return str:sub(1, id - 1) .. str:sub(id, id) .. str:sub(id + 1)
end

local function func(str)
	local new = ""
	for i = 1, #str do
		new = get_replaced_at(str, i)
	end
	return new
end

local function char_in_list(c, list)
	for i = 1, list.len, 1 do
		if list[i]:find(c) then
			return true
		end
	end

	return false
end

local function separator_chars()
	return { "_", " ", len = 2 }
end

local function print_list(list)
	for i = 1, list.len, 1 do
		print(list[i])
	end
end

local function add_in_list(el, list)
	list.len = list.len + 1
	list[list.len] = el
end

-- returns location of a word at id
local function word_at(str, check_case, id) end

-- splits given string and returns table of found words. splits by separator_chars()
-- pass true to check_case to make additional splits by casing
local function split_words(str, check_case)
	local words = { len = 0 }
	local w_start = 1
	local w_end = 1
	local w_in = false

	str = str .. " "

	for i = 1, #str do
		local c = str:sub(i, i)
		local is_upper = string.match(c, "%u")

		-- end of a word
		if char_in_list(c, separator_chars()) and w_in then
			w_end = i - 1
			w_in = false
			add_in_list(str:sub(w_start, w_end), words)
			goto continue
		end

		-- end of a word when camel or pascal case
		if check_case and is_upper then
			w_end = i - 1
			add_in_list(str:sub(w_start, w_end), words)

			-- start new word emidiately
			w_start = i
			w_end = i
			w_in = true
			goto continue
		end

		-- start of a word
		if not char_in_list(c, separator_chars()) and not w_in then
			w_start = i
			w_end = i
			w_in = true

			goto continue
		end

		::continue::
	end

	return words
end

print_list(split_words("ajksdh sakjh dakjdha kjdhakk_723   govnoGovno", true))
-- print_list(split_words("asjkdkhasAajsdsh"))
