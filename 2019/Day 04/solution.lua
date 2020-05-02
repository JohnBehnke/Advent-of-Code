
possible_solution = {}

for i=137683,596253 do
	has_adjacent = false
	strictly_increasing = true

	password = tostring(i)

	for j = 1, #password - 1  do
		if string.sub(password,j,j) == string.sub(password, j + 1,j+1) then
			has_adjacent = true
		end
		if tonumber(string.sub(password, j,j)) > tonumber(string.sub(password, j + 1,j+1))  then
			strictly_increasing = false
		end 
	end 

	if has_adjacent and strictly_increasing then
		table.insert(possible_solution, i)
	end
end
print(#possible_solution)
possible_solution = {}

for i=137683,596253 do
	has_adjacent = false
	strictly_increasing = true

	password = tostring(i)
	doubles = {}
	for j = 1, #password -1   do
		if string.sub(password,j,j) == string.sub(password, j + 1,j + 1) then

			if doubles[string.sub(password,j,j)] == nil  then
				doubles[string.sub(password,j,j)] = 2
			else
				doubles[string.sub(password,j,j)] = doubles[string.sub(password,j,j)] + 1
			end
			-- print(doubles[string.sub(password,j,j)])
		end
		if tonumber(string.sub(password, j,j)) > tonumber(string.sub(password, j + 1,j + 1))  then
			strictly_increasing = false
		end 
	end 

	for key, val in pairs(doubles) do

		if doubles[key] == 2 then
			has_adjacent = true
		end
	end
	if has_adjacent and strictly_increasing then
		table.insert(possible_solution, i)
	end
end

print(#possible_solution)