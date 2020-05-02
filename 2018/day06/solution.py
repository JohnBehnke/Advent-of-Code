
class location(object):
	def __init__(self, x, y, isInfinite=False):
		self.x = x
		self.y = y
		self.isInfinite = isInfinite
		self.closestCoordinate = '.'
		self.rep = '.'		

def readFile(inputFile):
	eventList = []
	
	return sorted(eventList)

def manhattanDistance(p, q):
	return abs(p[1] - q[1]) + abs(p[0] - q[0])

if __name__ == '__main__':

	coordinates = {}
	chars = [chr(i) for i in xrange(33,127)]
	chars.remove('.')

	c = 0
	for line in open('input.txt'):
		sL = line.strip().split(', ')
		coordinates[(int(sL[0]), int(sL[1]))] = chars[c]
		c += 1
		

	pgrid =  [ ['.'] * 500 for i in range(500) ]
	grid = []
	for x in range(len(pgrid)):
		row = []
		for y in range(len(pgrid[x])):
			if (x == 0 or x == len(pgrid) - 1) or (y == 0 or y == len(pgrid[x]) -1):
				row.append(location(x, y,True))
			else:
				row.append(location(x, y))
		grid.append(row)
	for x in range(len(grid)):
		for y in range(len(grid[x])):
			closestCoordinate = (1000,1000)
			for possibleCoor in coordinates.keys():
				if manhattanDistance(possibleCoor, (y,x)) < manhattanDistance(closestCoordinate, (y,x)):

					closestCoordinate = possibleCoor
					grid[x][y].closestCoordinate = coordinates[possibleCoor]
					grid[x][y].rep = coordinates[possibleCoor]

				elif manhattanDistance(possibleCoor, (y,x)) == manhattanDistance(closestCoordinate, (y,x)):

					closestCoordinate = possibleCoor
					grid[x][y].closestCoordinate = '.'
					grid[x][y].rep = '.'
					
	
	areInfinite = set()
	for x in range(len(grid)):
		for y in range(len(grid[x])):
			if grid[x][y].isInfinite:
				for char in grid[x][y].closestCoordinate:
					areInfinite.add(char)

	
	finiteCoordinates =  set(chars) - areInfinite

	linearGrid = ''
	for x in range(len(grid)):
		for y in range(len(grid[x])):
			for char in grid[x][y].closestCoordinate:
				linearGrid += char
	largestFiniteSize = 0
	for finite in finiteCoordinates:

		if linearGrid.count(str(finite)) > largestFiniteSize:
			largestFiniteSize = linearGrid.count(str(finite))
	print 'The largest area that is not infinite is: %d' %(largestFiniteSize)


	for x in range(len(grid)):
		for y in range(len(grid[x])):
			sumOfCoors = 0
			for coor in coordinates.keys():
				sumOfCoors += manhattanDistance(coor, (y,x))
			if sumOfCoors < 10000:
				grid[x][y].closestCoordinate = '#'
			else:
				grid[x][y].closestCoordinate = '.'
	linearGrid = ''
	for x in range(len(grid)):
		for y in range(len(grid[x])):
			for char in grid[x][y].closestCoordinate:
				linearGrid += char
	print 'The size of the region containing all locations which have a total distance to all given coordinates of less than 10000 is: %d'%(linearGrid.count('#'))



