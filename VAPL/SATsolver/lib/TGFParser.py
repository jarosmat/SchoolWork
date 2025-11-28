import sys


class TGFParser:
	def __init__(self, filename):
		self.filename = filename
		self.nodeEnd = '#'
		self.nodes = set()
		self.edges = dict()
		self.edgeTuples = []

	def ParseNodes(self, file):
		line = file.readline()
		while line != self.nodeEnd:
			lineParts = line.split()
			if len(lineParts) != 0:
				node = lineParts[0]
				self.nodes.add(node)
				self.edges[node] = []
			line = file.readline()

	def ParseEdges(self, file):
		line = file.readline()
		while line:
			if len(line) < 2:
				sys.stderr.write("Error: Invalid edge definition" + line + "\n")
				sys.exit(1)

			lineParts = line.split()
			node1 = lineParts[0]
			node2 = lineParts[1]

			if node1 not in self.nodes or node2 not in self.nodes:
				sys.stderr.write("Error: Invalid edge definition: node does not exist" + line + "\n")
				sys.exit(1)

			self.edges[node1].append(node2)
			self.edgeTuples.append((node1, node2))

	def ParseFile(self):
		with open(self.filename) as file:
			self.ParseNodes(file)
			self.ParseEdges(file)