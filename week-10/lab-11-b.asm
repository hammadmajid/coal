org 100h

.data
arr dw 1, 2, 3, 4, 5

.code
mov ax, @data
mov ds, ax

; access first element
mov bx, [arr]

; access middle element 3
mov cx, [arr+4]

; access last element
mov dx, [arr+8]

ret
