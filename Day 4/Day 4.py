def partOne(inputName):
	inputFile = open(inputName)
	valid = 0
	for line in inputFile:
		fullPhrase = line.strip().split(' ')
		fullSet = set(fullPhrase)
		if len(fullPhrase) == len(fullSet):
			valid += 1
	return valid

def partTwo(inputName):
	inputFile = open(inputName)
	valid = 0
	for line in inputFile:
		fullPhrase = line.strip().split(' ')
		sortedWords = [] #Sort each word and append.. easy to tell if anagram
		for word in fullPhrase:
			sortedWords.append(''.join(sorted(word)))
		if len(fullPhrase) == len(set(sortedWords)):
			valid += 1
	return valid

if __name__ == '__main__':
	print partOne('input.txt')
	print partTwo('input.txt')