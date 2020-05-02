
def readInput(input):
	file = open(input)
	for line in file:
		return line.strip().split(',')

def problem(inputList):
	x = 0
	y = 0
	z = 0

	distances = []

	for direction in inputList:
	  if direction == "n":
	    y += 1
	    z -= 1
	  if direction == "ne":
	    x += 1
	    z -= 1
	  if direction == "se":
	    x += 1
	    y -= 1
	  if direction == "s":
	    y -= 1
	    z += 1
	  if direction == "sw":
	    x -= 1
	    z += 1
	  if direction == "nw":
	    x -= 1
	    y += 1
	  distances.append((abs(x) + abs(y) + abs(z)) / 2)

	distance = (abs(x) + abs(y) + abs(z)) / 2
	print distance #part one
	print max(distances) #part two
if __name__ == '__main__':
	x = readInput('input.txt')
	problem(x)