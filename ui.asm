draw_interface:
    mov ax, 0x0013
    int 0x10

    call draw_background
    call draw_android_logo
    call draw_menu
    ret

draw_background:
    mov ax, 0xA000
    mov es, ax
    xor di, di
    mov cx, 320*200
    mov al, 0x01
    rep stosb
    ret

draw_android_logo:
    mov si, android_logo
    mov cx, 100
    mov dx, 20
    call draw_image
    ret

draw_menu:
    mov si, menu_title
    mov cx, 120
    mov dx, 130
    call draw_string

    mov si, menu_item1
    mov cx, 120
    mov dx, 150
    call draw_string

    mov si, menu_item2
    mov cx, 120
    mov dx, 165
    call draw_string

    ret

draw_image:
    ret

draw_string:
    mov ah, 0x0E
    .loop:
        lodsb
        test al, al
        jz .done
        int 0x10
        jmp .loop
    .done:
        ret

android_logo db 0
menu_title db "Select Android to boot:",0
menu_item1 db "1. Android x86",0
menu_item2 db "2. Recovery Mode",0
