.PHONY: all clean

all: out/sblove

out/sblove: src/main.asm
	mkdir -p out
	fasm src/main.asm out/sblove
	chmod +x out/sblove

clean:
	rm -r out

