org 100h
.data
        str1 db 0ah, 0dh, "First digit: $"
        str2 db 0ah, 0dh, "Second digit: $"
        str3 db 0ah, 0dh, "Result is: $"
.code
        mov ax, @data
        mov ds, ax

        lea dx, str1
        mov ah, 09h
        int 21h
        mov ah, 01h
        int 21h

        sub al, 30h
        mov bl, al
        lea dx, str2
        mov ah, 09h
        int 21h

        mov ah, 01h
        int 21h
        sub al, 30h
        mov bh, al

        ; combine two digits
        mov al, bl
        mov ah, 0
        mov cl, 10
        mul cl
        add al, bh
        mov bl, al

        ; Multiply
        mov al, bl
        mov ah, 0
        mov cx, ax
        mov ax, cx
        shl ax, 5 ; x * 32
        push ax
        mov ax, cx
        shl ax, 4 ; x * 16
        pop bx
        add ax, bx
        push ax
        mov ax, cx
        shl ax, 1 ; x * 2
        pop bx
        add ax, bx
        push ax ; save result

        lea dx, str3
        mov ah, 09h
        int 21h

        ; retrieve result
        pop ax

        ; Convert AX to decimal and print
        mov cx, 0
        mov bx, 10

convert_loop:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz convert_loop

print_loop:
        pop dx
        add dl, 30h
        mov ah, 02h
        int 21h
        loop print_loop
        ret

        
