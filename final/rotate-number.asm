.model small
.stack 100h
.data
    num dw 7678h     ; Number to rotate
    result dw 0      ; To store result
.code
start:
    mov ax, num      ; Load the number into AX
    ror ax, 1        ; Rotate AX right by 1 bit
    mov result, ax   ; Store the result

    mov ah, 4ch
    int 21h
end start
