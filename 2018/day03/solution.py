
class claim(object):
	def __init__(self, _id, left, top, width, height):
		self._id = _id
		self.left = left
		self.top = top
		self.top = top
		self.width = width
		self.height = height
		
class fabric(object):
	def __init__(self):
		self.fabric = [ ['.'] * 1000 for i in range(1000) ]
		self.conflicts = set()
			
	def placeClaims(self,claims):
		for claim in claims:
			for i in xrange(claim.top, claim.top + claim.height):
				for j in xrange(claim.left, claim.left + claim.width):
					if self.fabric[i][j] != '.':
						self.conflicts.add(self.fabric[i][j]) 
						self.conflicts.add(claim._id)
						self.fabric[i][j] = 'X'
					else: 
						self.fabric[i][j] = claim._id 
	def __str__(self):
		pfabric = ""
		for row in self.fabric:
			pfabric += ''.join(row) + '\n'
		return pfabric
		
def createClaims(inputList):
	claims = []
	for inputLine in inputList:
		splitLine = inputLine.strip().split(' ')
		_id = splitLine[0][1:]
		left = int(splitLine[2].split(',')[0])
		top = int(splitLine[2].split(',')[1][:-1])
		width = int(splitLine[3].split('x')[0])
		height = int(splitLine[3].split('x')[1])
		claims.append(claim(_id, left, top, width, height))
	return claims

def readFile(inputFile):
	inputList = []
	for line in open(inputFile):
		inputList.append(line.strip())
	return inputList		

if __name__ == '__main__':
	fabric = fabric()
	inputList = readFile('input.txt')
	claims = createClaims(inputList)
	fabric.placeClaims(claims)
	# Solution 1
	conflicted = 0
	for row in fabric.fabric:
		conflicted += row.count('X')
	print 'Solution 1: There are %d square inches of fabric with two or more claims'%conflicted

	# Solution 2
	claimIds = set()
	for claim in claims:
		claimIds.add(claim._id)
	print 'The ID of the only claim that does not have a conflict is %s'%(list(claimIds - fabric.conflicts)[0])





