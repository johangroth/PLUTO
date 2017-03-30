#!/bin/bash
# address offset in eeprogrammer is $8000

64tass --mw65c02  -o pluto.bin --flat --no-monitor --line-numbers --list=pluto.lst Tali-Main-B001.asm
