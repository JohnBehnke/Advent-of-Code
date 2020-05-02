from collections import deque

def listSolution(numberofPlayers, endGameValue):
	circle = [0]
	players = {}
	currentMarbleIndex = 0
	currentMarbleValue = 1

	for i in range(numberofPlayers):
		players[i] = 0

	while currentMarbleValue < endGameValue:
		for player in players.keys():
			# print circle, currentMarbleIndex
			if currentMarbleValue == 1:
				circle.append(1)
				currentMarbleIndex = 1
			elif currentMarbleValue % 23 ==0:
				players[player] += currentMarbleValue
				sevenMarblesOver = (currentMarbleIndex - 7) % len(circle)
				players[player] += circle.pop(sevenMarblesOver)
				currentMarbleIndex = sevenMarblesOver
			else:
				twoOver = (currentMarbleIndex + 2) % len(circle)
				circle.insert(twoOver, currentMarbleValue)
				currentMarbleIndex = twoOver 
			currentMarbleValue += 1
	return max(players.values())

def dequeSolution(numberofPlayers, endGameValue):

	circle = deque([0])
	players = {}
	currentMarbleIndex = 0
	currentMarbleValue = 1

	for i in range(numberofPlayers):
		players[i] = 0
	while currentMarbleValue < endGameValue:

		for player in players.keys():
			if currentMarbleValue % 23 ==0:
				players[player] += currentMarbleValue
				circle.rotate(7)
				players[player] += circle.pop()
				circle.rotate(-1)
			else:

				circle.rotate(-1)
				circle.append(currentMarbleValue)

			currentMarbleValue += 1
	return max(players.values())


if __name__ == '__main__':
	print 'The winning elf\'s score when %d elves play and the last marble is worth %d is: %d'%(465,71498,dequeSolution(465, 71498))
	print 'The winning elf\'s score when %d elves play and the last marble is worth %d is: %d'%(465,7149800,dequeSolution(465, 7149800))