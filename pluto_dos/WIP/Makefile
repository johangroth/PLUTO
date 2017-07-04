settime.bin.hex: settime.asm
	64tass --mw65c02  -o settime.bin --no-monitor --line-numbers --list=settime.lst settime.asm
	java -cp ../..:. uk.org.linuxgrotto.BinToHex settime.bin

clean:
	rm *.bin *.hex *.lst *~
