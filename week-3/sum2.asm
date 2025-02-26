.model small
org 100h

.code   
      
mov ax, 0h
mov bx, 0h
mov cx, 0h
mov dx, 0h
mov ds, ax

mov ax, 1
add ax, 2
add ax, 3
add ax, 4
add ax, 5
add ax, 6
add ax, 7
add ax, 8
add ax, 9
add ax, 10

mov bx, ax
mov cx, ax
mov dx, ax
mov ds, ax
