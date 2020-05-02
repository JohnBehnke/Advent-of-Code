'''
initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #
'''
def bootstrap(inputFile):
	rules = {}
	initalState = ['.','.','.']
	
	for line in open(inputFile):
		if 'initial state' in line:
			state = list(line.strip().split(': ')[1])
			initalState.extend(state)
			initalState.extend(['.','.','.','.','.'])
		if '=>' in line:
			rules[line.strip().split(' => ')[0]] = line.strip().split(' => ')[1]
	return rules, initalState
	
	
			

if __name__ == '__main__':
	rules, initalState = bootstrap('input.txt')
	
	generationLimit, currentGeneration = 20, 0
	
	while currentGeneration <= generationLimit:
		nextGeneration = []
		for i in range(len(initalState)):
			nextGeneration.append(initalState[i])
			if len(nextGeneration) >= 5:
				leftPots = ''.join(nextGeneration[-5:-3])
				centerPot = ''.join(nextGeneration[-3])
				rightPots = ''.join(nextGeneration[-2:])
				combinedPots = leftPots + centerPot + rightPots

				nextGeneration[-3] = rules[combinedPots]
								
		print ''.join(nextGeneration)
		initalState = nextGeneration[:]

		currentGeneration += 1			
			
'''
 0: ...#..#.#..##......###...###...........
 1: ...#...#....#.....#..#..#..#...........
 2: ...##..##...##....#..#..#..##..........
 3: ..#.#...#..#.#....#..#..#...#..........
 4: ...#.#..#...#.#...#..#..##..##.........
 5: ....#...##...#.#..#..#...#...#.........
 6: ....##.#.#....#...#..##..##..##........
 7: ...#..###.#...##..#...#...#...#........
 8: ...#....##.#.#.#..##..##..##..##.......
 9: ...##..#..#####....#...#...#...#.......
10: ..#.#..#...#.##....##..##..##..##......
11: ...#...##...#.#...#.#...#...#...#......
12: ...##.#.#....#.#...#.#..##..##..##.....
13: ..#..###.#....#.#...#....#...#...#.....
14: ..#....##.#....#.#..##...##..##..##....
15: ..##..#..#.#....#....#..#.#...#...#....
16: .#.#..#...#.#...##...#...#.#..##..##...
17: ..#...##...#.#.#.#...##...#....#...#...
18: ..##.#.#....#####.#.#.#...##...##..##..
19: .#..###.#..#.#.#######.#.#.#..#.#...#..
20: .#....##....#####...#######....#.#..##.
'''
