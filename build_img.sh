#!/bin/bash

asmFile=$1

#nasm boot.asm -o boot.bin
nasm $asmFile -o boot.bin
dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc
bochs -f bochsrc

