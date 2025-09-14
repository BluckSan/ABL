print_string:
    pusha
    mov ah, 0x0E
    .loop:
        lodsb
        test al, al
        jz .done
        int 0x10
        jmp .loop
    .done:
        popa
        ret

print_hex:
    pusha
    mov cx, 4
    .loop:
        rol dx, 4
        mov ax, dx
        and al, 0x0F
        add al, '0'
        cmp al, '9'
        jle .print
        add al, 7
    .print:
        mov ah, 0x0E
        int 0x10
        loop .loop
    popa
    ret
