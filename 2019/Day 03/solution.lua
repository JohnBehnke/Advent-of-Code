Point = {}
function Point:new(newMark, step)
	newObj = { mark = newMark, num_step = step}
	self.__index = self
	return setmetatable(newObj, self)
end

function create_directions_table(filename)
	input_file, err = io.open(filename)
	if err then print("Error"); return; end

	directions = {{},{}}
	wire = 1
	while true do
		Line = input_file:read()
		if Line == nil then break end
		for i in Line:gmatch("([^,]+)") do table.insert(directions[wire], i) end
		wire = wire + 1
	end
	return directions
end

directions = create_directions_table("input.txt")
circut_board = {}
intersections = {}
for i = 1, #directions do
	x_position = 0
	y_position = 0
	number_of_steps = 1
	for j = 1, #directions[i] do
		current_direction =  directions[i][j]:sub(0,1)
		amount_of_steps = tonumber(directions[i][j]:sub(2,directions[i][j].length))

		for _ = 1,amount_of_steps do
			if current_direction == 'U' then
				y_position  = y_position + 1
			elseif current_direction == 'D' then
				y_position  = y_position - 1
			elseif current_direction == 'L' then
				x_position  = x_position + 1
			elseif current_direction == 'R' then
				x_position  = x_position - 1
			end

			if circut_board[x_position] == nil then
				circut_board[x_position] = {[y_position] = Point:new(i, number_of_steps)}
			else
				currentPoint = circut_board[x_position][y_position]
				if currentPoint == nil then
					circut_board[x_position][y_position] = Point:new(i, number_of_steps)
				elseif y_position ~= 0 and x_position ~= 0 and (currentPoint).mark ~= i and (currentPoint).mark ~= 'X'  then
					existing_step = (circut_board[x_position][y_position]).num_step
					circut_board[x_position][y_position].num_step = number_of_steps + existing_step
					table.insert(intersections, {x_position, y_position})
				end
			end
			number_of_steps = number_of_steps + 1
		end
	end	
end

fewest_combined_steps_to_intersection = math.maxinteger
smallest_manhattan_distance = math.maxinteger

for i = 1, #intersections do
	manhattan_distance = math.abs(intersections[i][1]) + math.abs(intersections[i][2])
	if manhattan_distance < smallest_manhattan_distance then
		smallest_Manhattan_distance = manhattan_distance
	end
	intersection = circut_board[intersections[i][1]][intersections[i][2]]
	number_of_steps_to_intersection = intersection.num_step
	if number_of_steps_to_intersection < fewest_combined_steps_to_intersection then
		fewest_combined_steps_to_intersection = number_of_steps_to_intersection
	end
end
print(smallest_Manhattan_distance)
print(fewest_combined_steps_to_intersection)
