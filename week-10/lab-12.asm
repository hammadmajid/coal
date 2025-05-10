.model small
.stack 100h
.data
    array db 10, 20, 30, 40, 50

.code
main:
    mov ax, @data
    mov ds, ax

    ; Push each element
    mov al, array[0]
    push ax

    mov al, array[1]
    push ax

    mov al, array[2]
    push ax

    mov al, array[3]
    push ax

    mov al, array[4]
    push ax

    ; Pop back into array to reverse it
    pop ax
    mov array[0], al

    pop ax
    mov array[1], al

    pop ax
    mov array[2], al

    pop ax
    mov array[3], al

    pop ax
    mov array[4], al

    ; Exit program
    mov ah, 4ch
    int 21h
end main
