
def readFile(fname):

	file = open(fname)
	results = []
	for line in file:
		comm = {}
		pipe = line.strip().split(' <-> ')
		endOne = pipe[0]
		endTwo = pipe[1].split(',')
		for i,x in enumerate(endTwo):
			endTwo[i] = x.strip()
		comm[endOne] = endTwo
		results.append(comm)
	return results


def partOne(comms):
	x = comms
	commGroups = {}
	changed = True
	while changed:
		changed = False
		for comm in x:
			
			for key, val in comm.items():
				added = False
				for key2, val2 in commGroups.items():
					if key in val2:
						commGroups[key2] += val
						added = True
						changed = True
				if not added:
					commGroups[key] = val
					changed = True
	print commGroups
	print len(set(commGroups['0']))
				
if __name__ == '__main__':
	f = readFile('input.txt')
	partOne(f)

