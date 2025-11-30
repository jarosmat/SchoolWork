from lib.CNFEncoder import CNFEncoder
from lib.TGFParser import TGFParser
from argparse import ArgumentParser
import subprocess

def print_result(var_encoding, result):
	for line in result.stdout.decode('utf-8').split('\n'):
		print(line)
		if line.startswith('v'):
			res = line.split()

	code = result.returncode
	if code == 20:
		print("Specified graph does not possess a kernel")
		return

	print("Vertices in graph kernel", end=": ")
	for var in res:
		if var != 'v' and var != '0':
			if int(var) > 0:
				vertex = (var_encoding[int(var)])
				print(f'{var_encoding[int(var)]}, ', end="")

	print()

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
		default="./lib/glucose-syrup",
		type=str,
		help=(
			"Specify which SAT solver to use. "
		),
	)

	args = parser.parse_args()
	parser = TGFParser(args.input)

	parser.ParseFile()
	print("TGF file parsed")

	encoder = CNFEncoder(parser.nodes, parser.edges, parser.edgeTuples, args.formula_output)

	encoding = encoder.encode()
	print("CNF file encoded")

	res = subprocess.run([f'./{args.solver}', '-model', '-verb=', args.formula_output], stdout=subprocess.PIPE)

	print_result(encoding, res)

if __name__ == "__main__":
	main()
