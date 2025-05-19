.model small
.stack 100h
.data
    byte_val db 0b10110010b ; Input byte
    ones db 0               ; Counter for 1s
    zeros db 0              ; Counter for 0s
.code
start:
    mov al, byte_val        ; Load byte into AL
    mov cl, 8               ; Loop counter (8 bits)
    mov bl, 0               ; Ones count
    mov bh, 0               ; Zeros count

count_loop:
    shr al, 1               ; Shift right, LSB -> CF
    jnc is_zero
    inc bl                  ; If CF=1, increment ones
    jmp next
is_zero:
    inc bh                  ; If CF=0, increment zeros
next:
    dec cl
    jnz count_loop

    mov ones, bl
    mov zeros, bh

    mov ah, 4ch
    int 21h
end start
