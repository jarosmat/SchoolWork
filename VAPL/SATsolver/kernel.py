from lib.CNFEncoder import CNFEncoder
from lib.TGFParser import TGFParser
from argparse import ArgumentParser
import subprocess

def print_result(var_encoding, result):
	pass

def main():
	parser = ArgumentParser()

	parser.add_argument(
		"-i",
		"--input",
		type=str,
		help=(
			"File with TGF representation of graph"
		),
	)
	parser.add_argument(
		"-f",
		"--formula-output",
		default="formula.cnf",
		type=str,
		help=(
			"Output file for the DIMACS format (i.e. the CNF formula)."
		),
	)
	parser.add_argument(
		"-s",
		"--solver",
		default="glucose-syrup",
		type=str,
		help=(
			"Specify which SAT solver to use. "
		),
	)

	args = parser.parse_args()
	print("args parsed")
	parser = TGFParser(args.input)

	parser.ParseFile()
	print("TGF file parsed")

	encoder = CNFEncoder(parser.nodes, parser.edges, parser.edgeTuples, args.formula_output)

	encoding = encoder.encode()
	print("CNF file encoded")

	print(encoding)

	print(subprocess.run([args.solver, '-model', '-verb=', args.formula_output], stdout=subprocess.PIPE))

if __name__ == "__main__":
	main()
