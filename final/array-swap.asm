org 100h
.stack 100h

.data
    byte_array db 20 dup(100)
    word_array dw 20 dup(?)
    newline db 13, 10, '$'

.code
start:
    mov si, 0          ; index for byte_array
    mov di, 0          ; index for word_array

    mov cx, 20         ; loop counter

swap_loop:
    ; load byte from byte_array[si]
    mov al, [byte_array + si]
    ; zero-extend to AX
    mov ah, 0
    ; store AX to word_array[di]
    mov [word_array + di*2], ax

    ; display AX
    call print_num

    ; print newline
    mov dx, offset newline
    mov ah, 09h
    int 21h

    inc si
    inc di
    loop swap_loop

    ret

; ---------------------------
; print AX as decimal number
; ---------------------------
print_num:
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    mov bx, 10

.divide_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz .divide_loop

.print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop .print_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret
