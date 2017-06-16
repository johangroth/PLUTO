pluto.bin: main.asm zp_variables.asm rtc.asm 1511.asm 1511_constants.asm acia.asm via.asm utils.asm pluto_kernel.asm macros.asm
	64tass --mw65c02  -o pluto.bin --flat --no-monitor --line-numbers --list=pluto.lst main.asm

test.bin.hex: test.asm utils.asm 1511.asm 1511_constants.asm zp_variables.asm
	64tass --mw65c02  -o test.bin --no-monitor --line-numbers --list=test.lst test.asm
	java -cp ..:. uk.org.linuxgrotto.BinToHex test.bin

settime.bin.hex: settime.asm
	64tass --mw65c02  -o settime.bin --no-monitor --line-numbers --list=settime.lst settime.asm
	java -cp ..:. uk.org.linuxgrotto.BinToHex settime.bin

clean:
	rm *.bin *.hex *.lst *~
