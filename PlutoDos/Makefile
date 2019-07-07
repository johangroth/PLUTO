INCLUDE_SRCS = include/*.inc
ASM_SRCS = *.asm

pluto.bin: ${ASM_SRCS} ${INCLUDE_SRCS}
	64tass -o pluto.bin --nostart --no-monitor --line-numbers --tab-size=1 --list=pluto.lst main.asm

clean:
	rm  -f *.bin *.hex *.lst *~ pluto.bin
