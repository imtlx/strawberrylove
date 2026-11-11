.PHONY: all clean

all: out/bnuy

out/bnuy: src/main.asm
	mkdir -p out
	fasm src/main.asm out/bnuy
	chmod +x out/bnuy

clean:
	rm -r out

