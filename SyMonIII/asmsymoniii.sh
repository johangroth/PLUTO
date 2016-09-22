#!/bin/bash
# address offset in eeprogrammer is $8000

64tass --ascii -Wall -o symoniii.bin --flat --line-numbers --list=symoniii.lst symoniii.asm

