all: output/extracted.touch

output/extracted.touch:
	ls ../split/output | xargs -I {} sh -c 'echo "{}"; pdf2txt.py "../split/output/{}" > "output/{}.txt"'
	touch extracted.touch
