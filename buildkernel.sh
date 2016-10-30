#!/bin/bash
nasm -f elf32 entry.asm -o entry.o
cc -m32 -c -Wall c_start.c
ld -m elf_i386 -T link.ld -o hydrogen c_start.o entry.o
