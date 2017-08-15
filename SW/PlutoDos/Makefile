INCLUDE_SRCS = include/*.inc
ASM_SRCS = *.asm

pluto: bios.asm acia.asm rtc.asm via.asm ${INCLUDE_SRCS}
	64tass -o pluto --flat --no-monitor --line-numbers --list=pluto.lst main.asm

clean:
	rm  -f *.bin *.hex *.lst *~ pluto
