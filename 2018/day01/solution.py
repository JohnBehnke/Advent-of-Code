
def readFile(inputFile):
	numberList = []
	for line in open(inputFile):
		numberList.append(int(line))
	return numberList

if __name__ == '__main__':
	#Solution 1
	numberList  = readFile('input.txt')
	print sum(numberList)
	#Solution 2
	foundFrequencies = set()
	runningTotal = 0
	found = False
	while not found:
		for num in numberList:
			runningTotal += num
			if runningTotal in foundFrequencies:
				print runningTotal
				found = True
				break
			foundFrequencies.add(runningTotal)
