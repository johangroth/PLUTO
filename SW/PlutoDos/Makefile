INCLUDE_SRCS = include/*.inc
ASM_SRCS = *.asm

pluto.bin: cfs.asm main.asm bios.asm acia.asm rtc.asm via.asm ide_routines.asm ascii_to_bin.asm bin_to_ascii.asm monitor.asm ${INCLUDE_SRCS}
	64tass -o pluto.bin --nostart --no-monitor --line-numbers --tab-size=1 --list=pluto.lst main.asm
	ctags *.asm

clean:
	rm  -f *.bin *.hex *.lst *~ pluto.bin
