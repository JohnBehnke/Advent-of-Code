def partOne(input):
	inputFile = open(input)
	memoryBank = []
	raw = []
	for line in inputFile:
		raw = line.strip().split('	')
	for block in raw:
		memoryBank.append(int(block))
	cycles = 0
	distribute = 0
	index = 0
	configurations = set([])

	while True:
		maxBlock = max(memoryBank)
		index = memoryBank.index(maxBlock)
		count = index + 1
		distribute = maxBlock
		while distribute > 0:
			if count >= len(memoryBank):
				count = 0
			memoryBank[count] += 1
			distribute -= 1
			memoryBank[index] -= 1
			count += 1
		cycles += 1
		config = ''.join(map(str,memoryBank))
		if config in configurations:
			return cycles
		configurations.add(config)
		

def partTwo(input):
	inputFile = open(input)
	memoryBank = []
	raw = []
	for line in inputFile:
		raw = line.strip().split('	')
	for block in raw:
		memoryBank.append(int(block))
	cycles = 0
	distribute = 0
	index = 0
	configurations = {}

	while True:
		maxBlock = max(memoryBank)
		index = memoryBank.index(maxBlock)
		count = index + 1
		distribute = maxBlock
		while distribute > 0:
			if count >= len(memoryBank):
				count = 0
			memoryBank[count] += 1
			distribute -= 1
			memoryBank[index] -= 1
			count += 1
		
		config = ''.join(map(str,memoryBank))
		if config in configurations:
			return cycles - configurations[config]
		configurations[config] = cycles
		cycles += 1


if __name__ == '__main__':
	print partOne('input.txt')
	print partTwo('input.txt')
	