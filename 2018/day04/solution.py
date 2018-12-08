import datetime

def readFile(inputFile):
	eventList = []
	for line in open(inputFile):
		splitLine = line.strip().split(' ')
		date = ''.join(splitLine[0][1:][:10]).split('-')
		time = ''.join(splitLine[1][:-1]).split(':')
		dateTime = datetime.datetime(int(date[0]), int(date[1]), int(date[2]), int(time[0]), int(time[1]))

		eventList.append(Event(dateTime, line.strip()))
	return sorted(eventList)

class Event(object):
	def __init__(self, dateTime, statement):
		
		self.dateTime = dateTime
		self.statement = statement
		self._id = ''
		
		if '#' in statement.split(' ')[-3]:
			self._id = self.statement.split(' ')[-3][1:]
			self.type = "b"
		elif 'wakes' in statement:
			self.type = 'w'
		else:
			self.type = "s"

	def __cmp__(self, other):
		return cmp(self.dateTime, other.dateTime)

	def __str__(self):
		return ' | '.join([str(self.dateTime), self._id, self.type])

class guard(object):
	def __init__(self, _id, ):
		self._id = _id
		self.totalSleep = datetime.datetime(1,1,1,0,0,0)
		self.minutesSlept = [0] * 60
	def __cmp__(self,other):
		return cmp(self.totalSleep, other.totalSleep)
		

if __name__ == '__main__':
	events =  readFile('input.txt')
	guards = {}

	for event in events:
		if '#' in event.statement:
			guards[event._id] = guard(event._id)

	currentGuard = ''
	lastEventTime = datetime.datetime(1,1,1,0,0,0)
	sleepTime = 0
	awakeTime = 0
	for event in events:
		if event.type == 'b':
			currentGuard = event._id
			lastEventTime = event.dateTime
			sleepTime = 0
			awakeTime = 0
		if event.type == 's':
			lastEventTime = event.dateTime
			sleepTime = lastEventTime.minute
		if event.type == 'w':
			timeSlept = event.dateTime - lastEventTime
			lastEventTime = event.dateTime
			guards[currentGuard].totalSleep += timeSlept
			awakeTime =	lastEventTime.minute

			for t in range(0,60):
					if t >= sleepTime and t < awakeTime:
						guards[currentGuard].minutesSlept[t] += 1

	mostSleptGuard = max(guards.values())					
	idOfGuard = mostSleptGuard._id
	minuteMostSlept = mostSleptGuard.minutesSlept.index(max(mostSleptGuard.minutesSlept))			
	print 'The ID of the guard that slept the most (%s) multiplied by the minute that that guard spent asleep the most (%d) is: %d'%(idOfGuard, minuteMostSlept, minuteMostSlept * int(idOfGuard) )

	idOfGuard = ''
	minuteMostSlept = 0
	numberOfTimesSlept = 0
	for g in guards.keys():
		if max(guards[g].minutesSlept) > numberOfTimesSlept:
			minuteMostSlept = guards[g].minutesSlept.index(max(guards[g].minutesSlept))
			idOfGuard = g
			numberOfTimesSlept = max(guards[g].minutesSlept)

	print 'The ID of the guard (%s) that most frequently asleep on the same minute multiplied by that minute (%d) is: %d'%(idOfGuard, minuteMostSlept, minuteMostSlept * int(idOfGuard) )


		

