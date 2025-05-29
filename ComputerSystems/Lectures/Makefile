FILES = \
	output/CPU.pdf \
	output/Memory.pdf \
	output/ProgramingLanguages.pdf \
	output/OperatingSystems.pdf \
	output/ParalelProgramingAndSynchronization.pdf

all: $(FILES) output/ComputerSystems.pdf

.PHONY: all clean

clean:
	rm -f output/*

output/%.pdf: %.md
	pandoc --pdf-engine=wkhtmltopdf $< -o $@

output/ComputerSystems.pdf: $(FILES)
	pdfunite $(FILES) $@

