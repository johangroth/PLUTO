#!/bin/bash
# address offset in eeprogrammer is $8000

# 64tass --mw65c02 --ascii -Wall -o symoniii.bin --flat --line-numbers --list=symoniii.lst symoniii.asm
64tass --m65c02 -o symoniii.bin --flat --line-numbers --list=symoniii.lst symoniii.asm

