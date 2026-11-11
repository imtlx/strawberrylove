.PHONY: all clean run

all: out/sblove

run: out/sblove
	out/sblove

out/sblove: src/*
	mkdir -p out
	fasm src/main.asm out/sblove
	chmod +x out/sblove

clean:
	rm -r out

