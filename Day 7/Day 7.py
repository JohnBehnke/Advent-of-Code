def partOne(input):
	inputFile = open(input)
	tower = {}
	for line in inputFile:
		children = []
		if '->' in line:
			raw = line.strip().split(' -> ')
			holder = raw[0].strip()
			children = raw[1].strip().split(',')

			tower[holder] = map(lambda x: x.strip(), children)

	for key in tower.keys():
		name = key.strip().split(' ')[0]
		if name not in [item for sub in tower.values() for item in sub]:
			return name

def findSumChildren(root, weights ,tree):

	if root not in tree:
		return weights[root]
	results = []
	
	children = tree[root]
	test = {}
	for child in children:
		x = findSumChildren(child, weights ,tree)
		results.append(x)
		test[child] = x
	results.sort()

	if results[0] != results[-1]:

		diff = (results[0] - results[-1])



		if results.count(results[0]) > results.count(results[-1]):
			for key in test.keys():
				if test[key] == results[-1]:
					t = weights[key] + diff
					weights[key] += diff
					print t
					return t
		else:
			for key in test.keys():
				if test[key] == results[0]:
					t = weights[key] + diff
					weights[key] += diff
					return t
	else:
		results.append(weights[root])
		return sum(results)

def partTwo(input):
	inputFile = open(input)
	tower = {}
	weights = {}
	for line in inputFile:
		children = []
		if '->' in line:
			raw = line.strip().split(' -> ')
			holder = raw[0].strip()
			children = raw[1].strip().split(',')
			raw = holder.strip().split(' ')
			weight = int(raw[1][1:len(raw[1])-1])
			weights[raw[0]] = weight
			tower[raw[0]] = map(lambda x: x.strip(), children)
		else:
			raw = line.strip().split(' ')
			weight = int(raw[1][1:len(raw[1])-1])
			weights[raw[0]] = weight

	root = ''
	for key in tower.keys():
		raw = key.strip().split(' ')
		name = raw[0]
		if name not in [item for sub in tower.values() for item in sub]:
			root =  name
			break
	return findSumChildren(root, weights ,tower)
if __name__ == '__main__':
	print partOne('input.txt')
	print partTwo('input.txt')