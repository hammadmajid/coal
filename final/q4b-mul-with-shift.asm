org 100h
.stack 100h

.data
    result dw ?

.code
    mov ax, 6      ; load 6 into AX
    shl ax, 1      ; multiply by 2 -> ax = 6 * 2 = 12
    shl ax, 1      ; multiply by 2 again -> ax = 12 * 2 = 24
    mov result, ax ; store result (24)

ret
