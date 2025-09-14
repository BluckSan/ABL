[bits 16]
[org 0x7E00]

stage2_start:
    mov ax, 0
    mov ds, ax
    mov es, ax

    call load_ui
    call load_menu

    main_loop:
        call draw_interface
        call handle_input
        jmp main_loop

%include "ui.asm"
%include "menu.asm"
%include "disk.asm"
%include "print.asm"

load_ui:
    mov bx, 0x8000
    mov dh, 32
    mov dl, [boot_drive]
    call disk_load
    ret

load_menu:
    mov bx, 0xA000
    mov dh, 8
    mov dl, [boot_drive]
    call disk_load
    ret
