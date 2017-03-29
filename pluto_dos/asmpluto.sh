#!/bin/bash
# address offset in eeprogrammer is $8000

64tass --mw65c02  --no-monitor -o pluto.bin --flat --no-monitor --line-numbers --list=pluto.lst Tali-Main-B001.asm
# 64tass --m65c02 -o symoniii.bin --flat --line-numbers --list=symoniii.lst symoniii.asm
