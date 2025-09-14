[org 0x7C00]
[bits 16]

%define STAGE2_OFFSET 0x7E00

section .text
global _start

_start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov [boot_drive], dl

    mov ax, 0x0003
    int 0x10

    mov si, abl_logo
    call print_string

    mov bx, STAGE2_OFFSET
    mov dh, 16
    mov dl, [boot_drive]
    call disk_load

    jmp STAGE2_OFFSET

%include "print.asm"
%include "disk.asm"

boot_drive db 0
abl_logo db 13,10
          db "  ___  _    _ _      ",13,10
          db " / _ )| |_ | | | ___ ",13,10
          db "/ / _/|  _|| | |/ -_)",13,10
          db "\____/ \__||_|_|\___|",13,10
          db "Android-Boot-Loader",13,10,13,10,0

times 510-($-$$) db 0
dw 0xAA55
