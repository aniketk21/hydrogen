;    Hydrogen: A bare-bones kernel.
;    Copyright (C) 2016  Aniket Kulkarni kaniket21@gmail.com
;    
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.

[BITS 32]

section .text
dd MULTIBOOT_HEADER_MAGIC
dd MULTIBOOT_HEADER_FLAGS
dd MULTIBOOT_CHECKSUM
align 4
MULTIBOOT_PAGE_ALIGN equ 1<<0
MULTIBOOT_MEMORY_INFO equ 1<<1
MULTIBOOT_VIDEO_INFO equ 1<<2
MULTIBOOT_HEADER_MAGIC equ 0x1BADB002
MULTIBOOT_HEADER_FLAGS equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO | MULTIBOOT_VIDEO_INFO
MULTIBOOT_CHECKSUM equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)


    extern c_start ; c function to call
    global asm_start
asm_start:
    push ebx ; param to multiboot
    call c_start ; call c function
    hlt
