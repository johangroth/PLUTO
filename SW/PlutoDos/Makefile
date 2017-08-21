INCLUDE_SRCS = include/*.inc
ASM_SRCS = *.asm

pluto.bin: bios.asm acia.asm rtc.asm via.asm ${INCLUDE_SRCS}
	64tass -o pluto.bin --flat --no-monitor --line-numbers --list=pluto.lst main.asm
	ctags *.asm

clean:
	rm  -f *.bin *.hex *.lst *~ pluto
