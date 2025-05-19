.model small
.stack 100h
.data
    num1 db -3        ; First number (-3)
    num2 db 4         ; Second number (4)
    result db 0       ; To store product
.code
start:
    mov al, num1      ; Load -3 into AL
    neg al            ; Convert to positive (AL = 3)
    mov cl, num2      ; Load 4 into CL
    mov bl, al        ; Copy AL to BL
    shl bl, 2         ; Multiply by 4 (shift left by 2)
    neg bl            ; Negate to restore sign
    mov result, bl    ; Store final result

    mov ah, 4ch
    int 21h
end start
