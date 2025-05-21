include 'emu8086.inc'

org 100h
.stack 100h
    newline db 13, 10, '$'

.code

    ; original number
    mov ax, 8765h ; 6587h
    mov bx, ax
    call print_num_uns

    ; newline
    mov dx, offset newline
    mov ah, 09h
    int 21h

    ; rotate
    mov ax, bx
    ror ax, 8

    call print_num_uns

ret

DEFINE_PRINT_NUM_UNS
