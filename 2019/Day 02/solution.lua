inputFile, err = io.open("input.txt")
if err then print("Error"); return; end

codes = {}

line = inputFile:read()
for w in line:gmatch("([^,]+)") do  table.insert(codes, tonumber(w)) end
-- Lua indexes starting at 1 ... yikes
codes[2] = 12
codes[3] = 2
instruction_pointer = 1
while true do  -- #v is the size of v for lists.	
	if codes[instruction_pointer] == 1 then
		param_one = codes[instruction_pointer + 1]
		param_two = codes[instruction_pointer + 2]
		param_three = codes[instruction_pointer + 3]
		codes[param_three + 1] = codes[param_one + 1] + codes[param_two + 1]
	elseif codes[instruction_pointer] == 2 then
		param_one = codes[instruction_pointer + 1]
		param_two = codes[instruction_pointer + 2]
		param_three = codes[instruction_pointer + 3]
		codes[param_three + 1] = codes[param_one + 1] * codes[param_two + 1]
  	elseif codes[instruction_pointer] == 99 then
		break
	elseif codes[instruction_pointer] ~= 99 and codes[instruction_pointer] ~= 2 and codes[instruction_pointer] ~= 1 then
		print('Whoa')
		break
	end
	instruction_pointer = instruction_pointer + 4
end
-- 1450628
print('Done')
print(codes[1])

inputFile, err = io.open("input.txt")
if err then print("Error"); return; end

codes = {}

line = inputFile:read()
for w in line:gmatch("([^,]+)") do  table.insert(codes, tonumber(w)) end
-- Lua indexes starting at 1 ... yikes

-- Lua only does by reference, no by value
function table.clone(org)
  return {table.unpack(org)}
end

for noun = 0,99 do
	for verb = 0,99 do
		workingCodes = table.clone(codes)
		workingCodes[2] = noun
		workingCodes[3] = verb
		instruction_pointer = 1
		while true do  -- #v is the size of v for lists.	
			if workingCodes[instruction_pointer] == 1 then
				param_one = workingCodes[instruction_pointer + 1]
				param_two = workingCodes[instruction_pointer + 2]
				param_three = workingCodes[instruction_pointer + 3]
				workingCodes[param_three + 1] = workingCodes[param_one + 1] + workingCodes[param_two + 1]
			elseif workingCodes[instruction_pointer] == 2 then
				param_one = workingCodes[instruction_pointer + 1]
				param_two = workingCodes[instruction_pointer + 2]
				param_three = workingCodes[instruction_pointer + 3]
				workingCodes[param_three + 1] = workingCodes[param_one + 1] * workingCodes[param_two + 1]
		  	elseif workingCodes[instruction_pointer] == 99 then
				break
			elseif workingCodes[instruction_pointer] ~= 99 and workingCodes[instruction_pointer] ~= 2 and codes[instruction_pointer] ~= 1 then
				workingCodes = codes
				break
			end
			instruction_pointer = instruction_pointer + 4
		end
		if workingCodes[1] == 19690720 then
			print('found')
			print(100 * noun + verb)
		end
	end
end