if __name__ == '__main__':
	grid = [[0] * 301 for i in range(0,301)]

	gridSerialNumber = 5153
	for y in range(1,301):
		for x in range(1,301):
			rackID = x + 10
			powerLevel = rackID * y
			powerLevel += gridSerialNumber
			powerLevel *= rackID
			parsing = str(powerLevel)
			if len(parsing) >= 3:
				powerLevel = int(parsing[-3])
			else:
				powerLevel = 0
			powerLevel -= 5
			
			grid[y][x] = powerLevel
	# Part One, this actually runs kinda ok
	maxLevel = (0,0,0)
	for y in range(1,298):
		for x in range(1,298):

			value = sum(grid[y][x: x + 3]) + sum(grid[y + 1][x:x+3]) + sum(grid[y + 2][x:x + 3])
			if value > maxLevel[0]:
				maxLevel = (value, x, y)
	print "The X,Y coordinate of the top-left fuel cell of the 3x3 square with the largest total power is: %d,%d"%(maxLevel[1], maxLevel[2])
	
	# Part Two, takes about 10 minutes to run becasue I'm bad
	maxLevel = (0,0,0)
	for z in range(1,301):
		for y in range(1, 301 - z):
			for x in range(1, 301 - z):
				value = 0
				for i in range(z):
					value += sum(grid[y + i][x: x + z])

				if value > maxLevel[0]:
					maxLevel = (value, x, y, z)
	print "The X,Y,Size identifier of the square with the largest total power is %d,%d,%d"%(maxLevel[1], maxLevel[2], maxLevel[3])
	
	

			
