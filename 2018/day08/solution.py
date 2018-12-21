def partOne(license):
	answer = 0
	childCount = license.pop(0)
	metaDataCount = license.pop(0)

	for i in range(childCount):
		sub = partOne(license)
		answer += sub
	for i in range(metaDataCount):
		answer += license.pop(0)

	return answer

def partTwo(license):
	childCount = license.pop(0)
	metaDataCount = license.pop(0)

	if childCount > 0:
		childMetaData = []
		for i in range(childCount):
			childMetaData.append(partTwo(license))
		metaDataIndexes = []
		for i in range(metaDataCount):
			metaDataIndexes.append(license.pop(0))

		ans = 0
		for index in metaDataIndexes:
			combo = index - 1
			if combo >=0 and combo < len(childMetaData):
				ans += childMetaData[combo]
		return ans
	else:
		ans = 0
		for i in range(metaDataCount):
			ans += license.pop(0)
		return ans

if __name__ == '__main__':

	file = open('input.txt')
	license = list(file.read().strip().split(' '))
	file.close()

	license = map(int, license)

	answer= partOne(license[:])
	print 'The sum of all metadata entries is: %d'%(answer)

	answer = partTwo(license[:])
	print 'The value of the root node is: %d'%(answer)
