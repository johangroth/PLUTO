INCLUDE_SRCS = include/*.inc

pluto: bios.asm acia.asm rtc.asm via.asm ${INCLUDE_SRCS}
	64tass -o pluto --no-monitor --line-numbers --list=pluto.lst main.asm

clean:
	rm  -f *.bin *.hex *.lst *~ pluto
