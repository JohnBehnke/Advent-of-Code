def readFile(inputFile):
	stringList = []
	for line in open(inputFile):
		stringList.append(line.strip())
	return stringList

if __name__ == '__main__':
	stringList = readFile('input.txt')
	#Solution 1
	two, three = 0, 0
	for word in stringList:
		reduced = {}
		for char in word:
			if char in reduced:
				reduced[char] += 1
			else:
				reduced[char] = 1
		twoFound, threeFound = False, False
		for key, val in reduced.iteritems():
			if val == 2 and not twoFound:
				two += 1
				twoFound = True
			if val == 3 and not threeFound:
				three += 1
				threeFound = True
	print two * three
	#Solution 2
	#This is gross
	for word1 in stringList:
		for word2 in stringList:
			if word1 != word2:
				diffFound = False
				diffIndex = -1
				for i in xrange(0,len(word1)):
					if word1[i] != word2[i]:
						if diffFound == True:
							diffFound = False
							break
						diffFound = True
						diffIndex = i
				if diffFound:
					l = list(word1)
					reducedString = ''.join(l[:diffIndex] + l[diffIndex + 1:])
					print reducedString 
					exit()
					