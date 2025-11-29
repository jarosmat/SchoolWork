import random
import sys
from argparse import ArgumentParser


def generate(filename, n, m = None):
	if m is None:
		m = random.randint(1, n * n)

	with open(filename, "w") as f:
		i = 1
		while i <= n:
			f.write(f'{i}\n')
			i += 1

		f.write(f'#\n')

		i = 1
		while i <= m:
			node1 = random.randint(1, n)
			node2 = random.randint(1, n)
			while node1 == node2:
				node2 = random.randint(1, n)

			f.write(f"{node1} {node2}\n")
			i += 1


if __name__ == "__main__":
	parser = ArgumentParser()

	parser.add_argument(
		"-n",
		type=int,
		help=(
			"Number of vertices in graph"
		),
	)
	parser.add_argument(
		"-m",
		type=int,
		help=(
			"Number of edges in graph"
		),
	)
	parser.add_argument(
		"-o",
		"--output-file",
		default="out.tgf",
		type=str,
		help=(
			"File where to write the generated graph"
		),
	)

	args = parser.parse_args()
	generate(args.output_file, args.n, args.m)


