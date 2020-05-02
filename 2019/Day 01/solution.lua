inputFile, err = io.open("./input.txt")
if err then print("Error"); return; end

fuelRequirements = 0
while true do
	line = inputFile:read()
	if line == nil then break end
	mass = tonumber(line)
	fuelAmount = math.floor((mass / 3)) - 2
	fuelRequirements = fuelRequirements + fuelAmount

end
print(fuelRequirements)


inputFile, err = io.open("./input.txt")
if err then print("Error"); return; end
fuelRequirements = 0
while true do
        line = inputFile:read()
        if line == nil then break end
        mass = tonumber(line)
	totalModuleMass = 0
	while mass > 0 do
		fuelAmount = math.floor((mass / 3)) - 2
		if fuelAmount <= 0 then
			break
		end
        	mass = fuelAmount
		totalModuleMass = totalModuleMass + mass
		
	end
        fuelRequirements = fuelRequirements + totalModuleMass

end
inputFile:close()
print(fuelRequirements)
