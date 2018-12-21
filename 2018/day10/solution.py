class Point (object):
	def __init__(self, x, y, dx, dy):
		self.x = x
		self.y = y
		self.dx = dx
		self.dy = dy
		
		
	def simForward(self):
		self.x += self.dx
		self.y += self.dy
	def simBackward(self):
		self.x -= self.dx
		self.y -= self.dy
		
def boundingBoxArea(points):
	l,w = 0,0
	
	xs = []
	ys = []
	
	for point in points:
		xs.append(point.x)
		ys.append(point.y)
	return (min(xs), max(xs), min(ys), max(ys))

def printSky(sky, a, b):
	printSky = [['.'] * (a + 30) for i in range(b + 10)]
			
	for point in sky:
				
		x = point.x % (a + 30)
		y = point.y % (b  + 10)
				
				
		printSky[y][x] = '#'
					
	for line in printSky:
		print ''.join(line)

if __name__ == '__main__':
	sky = []
	c = 1
	for line in open('input.txt'):
		sL = line.strip().split('> ')
		x = int(sL[0].split(', ')[0].split('=<')[1])
		y = int(sL[0].split(', ')[1])
		
		dx = int(sL[1].split(', ')[0].split('=<')[1])

		dy = int(sL[1].split(', ')[1][:-1])
		sky.append(Point(x,y,dx,dy))
		
	xmin, xmax, ymin, ymax = boundingBoxArea(sky)
	lastBBArea = (xmax - xmin) * (ymax - ymin)
	finding = True
	c = 0
	while finding:
		xmin, xmax, ymin, ymax = boundingBoxArea(sky)
		currentBBArea = (xmax - xmin) * (ymax - ymin)
		if currentBBArea > lastBBArea:
			searching = True
			while searching:
				xmin, xmax, ymin, ymax = boundingBoxArea(sky)
				printSky(sky, (xmax - xmin), (ymax - ymin))
				print c
				found = raw_input("Is this correct? Press 'y' when the mesage is found... => ")
				if found == "y":
					print 'Solution found at t=%d'%(c)
					searching = False
					finding = False
				else:
					for point in sky:
						point.simBackward()
					c -= 1
		else:
			lastBBArea = currentBBArea
			for point in sky:
				point.simForward()
			c += 1

#ERCXLAJL
				
		
	
		
# 		if currentBBArea <= initLastBBArea * 0.0000001:
