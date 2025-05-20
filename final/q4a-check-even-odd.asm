org 100h
.stack 100h

.data
    even_msg db 'Even$', 0
    odd_msg  db 'Odd$', 0

.code
    mov ax, 5          ; change this value to test different numbers
    test ax, 1         ; test least significant bit
    jz is_even         ; if zero flag is set, number is even

is_odd:
    mov dx, offset odd_msg
    jmp print_msg

is_even:
    mov dx, offset even_msg

print_msg:
    mov ah, 9
    int 21h
ret
