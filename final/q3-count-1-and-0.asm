include 'emu8086.inc'

org 100h
.stack 100h

.data
   msg1 db 'Ones: $'
   msg2 db 13, 10, 'Zeros: $'

.code
    mov ax, @data
    mov ds, ax

    mov bx, 0 ; reset: bl for zeros and bh for ones

    mov cx, 8
    mov al, 10110110b

count_loop:
    ror al, 1
    jc is_one
    inc bl
    jmp next
is_one:
    inc bh
next:
    loop count_loop

    ; print number of ones
    lea dx, msg1
    mov ah, 09h
    int 21h

    mov ah, 0 ; reset higher bits
    mov al, bh
    call print_num_uns

    lea dx, msg2
    mov ah, 09h
    int 21h

    mov ah, 0
    mov al, bl
    call print_num_uns

DEFINE_PRINT_NUM_UNS
