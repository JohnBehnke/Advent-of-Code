class Node(object):
	def __init__(self, _id, tail):
		self._id = _id
		self.tail = tail
		self.visited = -1
		self.edge = 0


# Tried doing a normal topological sort, but it needs to be lexicographical	
# def topologicalSort(nodes):
# 	ordering = []
# 	print nodes.keys()
# 	for node in nodes.keys():
# 		if nodes[node].visited == -1:
# 			nodes, ordering, = visit(nodes[node]._id, ordering, nodes)

# 	return ordering
# def visit(_id, ordering, nodes):
	
# 	if nodes[_id].visited == 0:
# 		return nodes, ordering
# 	if nodes[_id].visited == -1:
# 		nodes[_id].visited = 0
# 		for n in nodes[_id].tail:
# 			# print _id,  nodes[_id].tail
# 			nodes, ordering = visit(n, ordering, nodes)
# 		# print _id
# 		nodes[_id].visited = 1
# 		ordering.insert(0,_id)
# 		# print ordering
# 	return nodes, ordering

def lexiTopoSort(s, nodes):
	l = []
	while len(s)  > 0:
		node = s.pop(0)
		l.append(node)
		for m in nodes[node].tail:
			# print nodes[m].edge
			nodes[m].edge -= 1
			if nodes[m].edge == 0:
				s.append(m)
				s.sort()
	return l

def lexiTopoSortWorkers(s, nodes, timings):



	numWorkersAvailable = 5
	t = 0
	inProgress = {}
	l = []

	while len(l) < len(nodes):

		for n in (inProgress.keys()):
			if inProgress[n] == t:
				del inProgress[n]
				l.append(n)
				numWorkersAvailable += 1
				for m in (nodes[n].tail):
					nodes[m].edge -= 1
					if nodes[m].edge == 0:
						s.append(m)
		while numWorkersAvailable  > 0 and len(s) > 0:
			node = s.pop(0)
			inProgress[node] = t + timings[node] + 60
			numWorkersAvailable -= 1
			
		if len(l) < len(nodes):
			t += 1
	return t

if __name__ == '__main__':
	nodes = {}
	incoming = set()
	for line in open('input.txt'):
		splitLine = line.strip().split(' ')
		#Step C must be finished before step A can begin.
		head = splitLine[1]
		tail = splitLine[-3]
		incoming.add(tail)
		if head in nodes:
			nodes[head].tail.append(tail)
		else:
			nodes[head] = Node(head, [tail])
		if tail not in nodes:
			nodes[tail] = Node(tail, [])
	for n in nodes.keys():
		for t in nodes[n].tail:
			nodes[t].edge += 1
	rootNodes = set(nodes.keys()) - incoming

	timings = {}
	c = 1
	for n in sorted(nodes.keys()):
		timings[n] = c
		c += 1
	print 'The order that the instructions should be compelted is: %s'%(''.join(lexiTopoSort(sorted(list(rootNodes)), nodes)))

	for n in nodes.keys():
		for t in nodes[n].tail:
			nodes[t].edge += 1

	print 'With 5 workers, it will take %d seconds to complete all of the steps.'%(lexiTopoSortWorkers(sorted(list(rootNodes)), nodes, timings))


	