.model small
.stack 100h
.data
    num db 10110110b ; 8-bit binary number
    ones db 0
    zeros db 0

    msg1 db 'Number of 1s: $'
    msg2 db 13, 10, 'Number of 0s: $'

.code
main:
    mov ax, @data
    mov ds, ax

    mov cx, 8          ; loop 8 times for 8 bits
    mov al, num        ; load binary number into AL

count_loop:
    ror al, 1          ; rotate right through carry
    jc is_one          ; if carry is set, it's a 1
    inc zeros
    jmp next
is_one:
    inc ones
next:
    loop count_loop

    ; Print "Number of 1s: "
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Print ones count
    mov al, ones
    call print_digit

    ; Print "Number of 0s: "
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Print zeros count
    mov al, zeros
    call print_digit

    ; Exit to DOS
    mov ah, 4Ch
    int 21h

;-----------------------------------
; Print single digit number in AL
;-----------------------------------
print_digit:
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    ret

end main
