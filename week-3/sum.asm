.model small
.data
a db 15
b db 11
sum1 db 0

.code    

mov ax, @data
mov ds, ax

mov ah, a
mov al, b
add al, ah

mov sum1, al

