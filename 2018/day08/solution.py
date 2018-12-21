def partOne(license):

	answer = 0
	childCount = license.pop(0)
	metaDataCount = license.pop(0)

	for i in range(childCount):
		sub, license = partOne(license)
		answer += sub
	for i in range(metaDataCount):
		answer += license.pop(0)

	return answer, license

def partTwo(license):
	childCount = license.pop(0)
	metaDataCount = license.pop(0)

	if childCount:
		t = []
		for i in range(childCount):
			subAns, license = partTwo(license)
			t.append(subAns)
		y = []
		for i in range(metaDataCount):
			y.append(license.pop(0))

		ans = 0
		for i in y:
			combo = i - 1
			if combo >=0 and combo < len(t):
				ans += t[combo]
		return ans, license
	else:
		ans = 0
		for i in range(metaDataCount):
			ans += license.pop(0)
		return ans, license

if __name__ == '__main__':
	file = open('input.txt')
	license = list(file.read().strip().split(' '))
	license = map(int, license)
	file.close()
	answer, license1 = partOne(license)
	file = open('input.txt')
	license = list(file.read().strip().split(' '))
	license = map(int, license)
	file.close()
	answer, license1 = partTwo(license)
	print answer

	#17037