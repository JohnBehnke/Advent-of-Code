def partOne(numberofPlayers, endGameValue):
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
			#place marble at + 2
			currentMarbleValue += 1
	return max(players.values())



if __name__ == '__main__':
	


	print partOne(465, 71498)