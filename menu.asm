handle_input:
    mov ah, 0
    int 0x16

    cmp al, '1'
    je load_android
    cmp al, '2'
    je load_recovery
    cmp al, 27
    je reboot
    ret

load_android:
    mov si, loading_android
    call print_string

    mov bx, 0x1000
    mov dh, 64
    mov dl, [boot_drive]
    call disk_load

    mov si, cmdline
    jmp 0x1000

load_recovery:
    mov si, loading_recovery
    call print_string
    jmp $

reboot:
    db 0x0EA
    dw 0x0000
    dw 0xFFFF

loading_android db "[ABL] Loading Android...",0
loading_recovery db "[ABL] Loading Recovery...",0
cmdline db "root=/dev/sda1 init=/init quiet",0
