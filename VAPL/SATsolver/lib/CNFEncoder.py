class CNFEncoder:
	def __init__(self, nodes, edges, edgeTuples, outputFile):
		self.nodes = nodes
		self.edges = edges
		self.edgeTuples = edgeTuples
		self.outputFile = outputFile

	def encode(self):
		i = 1
		nodeEncoding = dict()
		for node in self.nodes:
			nodeEncoding[node] = i
			i += 1

		with open(self.outputFile, "w") as file:
			n = len(self.nodes)
			m = len(self.edgeTuples)
			file.write(f'p cnf {n} {n + m}\n')

			for edge in self.edgeTuples:
				node1 = nodeEncoding[edge[0]]
				node2 = nodeEncoding[edge[1]]

				file.write(f'-{node1} -{node2} 0\n')

			for node in self.nodes:
				nodeEnc = nodeEncoding[node]
				neighbors = self.edges[node]

				file.write(f'{nodeEnc} ')

				for n in neighbors:
					file.write(f'{nodeEncoding[n]} ')

				file.write(f'0\n')


		return nodeEncoding