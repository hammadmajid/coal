org 100h

; 16 bit
mov ax, 0abcdh
mov dx, 3127
out dx, ax
mov ax, 0
in ax, dx

; 8 bit
mov bl, 10101010b
in 111, bl
mov bl, 0
in bl, 111

hlt
