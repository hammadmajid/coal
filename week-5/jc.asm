org 100h

mov ax, 1h
mov bx, 2h
add ax, bx
jc label_1:        
jnc label_2:

label_1:
mov ax, 000h
hlt

label_2:
mov ax, 1111h

hlt

