org 100h ; make tiny com file

mov ax, 6h  ; move 6 (hexadecimal) value into 16 bit ax register
mov bx, 2h  ; move 2 (hexadecimal) value into 16 bit bx register

add ax, bx ; add value of ax and bx register and store in ax

int 21h ; exit
ret
