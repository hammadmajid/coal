org 100h

.data
arr db 1, 2, 3, 4, 5

.code
mov ax, @data
mov ds, ax

; access first element
mov bl, [arr]

; access middle element 3
mov cl, [arr+2] 

; access last element
mov ch, [arr+4]


ret
