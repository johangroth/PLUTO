all:
	64tass --mw65c02  -o pluto.bin --flat --no-monitor --line-numbers --list=pluto.lst main.asm

test.bin.hex: test.asm
	64tass --mw65c02  -o test.bin --no-monitor --line-numbers --list=test.lst test.asm
	java -cp ..:. uk.org.linuxgrotto.BinToHex test.bin


