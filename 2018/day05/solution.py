
def react(polymer):
	stablePolymer = []

	for unit in polymer:
		if stablePolymer and (stablePolymer[-1].lower() == unit.lower() and (stablePolymer[-1].isupper() == unit.islower() or stablePolymer[-1].islower() == unit.isupper())):
			stablePolymer.pop()
		else:
			stablePolymer.append(unit)
	return stablePolymer

if __name__ == '__main__':
	file = open('input.txt')
	polymer = list(file.read().strip())
	file.close()

	units = set()
	for unit in polymer:
		units.add(unit.lower())

	stablePolymer = react(polymer)

	
	print len(stablePolymer)

	possibleShortestStablePolymers = []

	for unit in units:
		polymer = ''.join(polymer)
		reducedPolymer = polymer.replace(unit, '').replace(unit.upper(), '')
		possibleShortestStablePolymers.append(len(react(reducedPolymer)))
	print min(possibleShortestStablePolymers)
