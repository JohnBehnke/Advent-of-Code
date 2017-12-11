def partTwo(input):
	inputFile = open(input)
	steps = 0
	jumpValue = 0 
	index = 0
	instructionList = []
	for line in inputFile:
		fullPhrase = line.strip()
		instructionList.append(int(fullPhrase))
	while index >= 0 and index <= len(instructionList) - 1:
		jumpValue = instructionList[index]
		if jumpValue >= 3:
			instructionList[index] -= 1
		else:
			instructionList[index] += 1
		index += jumpValue
		steps += 1

	print steps

def partOne(input):
	inputFile = open(input)
	steps = 0
	jumpValue = 0 
	index = 0
	instructionList = []
	for line in inputFile:
		fullPhrase = line.strip()
		instructionList.append(int(fullPhrase))
	while index >= 0 and index <= len(instructionList) - 1:
		jumpValue = instructionList[index]
		instructionList[index] += 1
		index += jumpValue
		steps += 1

	print steps

if __name__ == '__main__':
	partOne('input.txt')
	partTwo('input.txt')
