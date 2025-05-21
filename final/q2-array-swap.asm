include 'emu8086.inc'

org 100h
.stack 100h

.data
    barr db 20 dup(100)
    warr dw 20 dup(?)
    newline db 13, 10, '$'

.code
    mov si, 0
    mov di, 0

    mov cx, 20

swap_loop:
    mov al, [barr + si]
    mov ah, 0

    mov [warr + di*2], ax

    call print_num_uns

    mov dx, offset newline
    mov ah, 09h
    int 21h

    inc si
    inc di
    loop swap_loop

    ret

DEFINE_PRINT_NUM_UNS
