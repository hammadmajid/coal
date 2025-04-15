.model small            ; Define memory model as small (1 code segment, 1 data segment)
.stack 100h             ; Allocate 256 bytes for the stack

.data                   ; Start of data segment
    num1 dw 1234h       ; Define a 16-bit number (e.g., 0x1234 or 4660 in decimal)

.code                   ; Start of code segment
start:
    mov ax, @data       ; Initialize DS register with the address of the data segment
    mov ds, ax

    mov ax, num1        ; Load the 16-bit value from memory (num1) into AX
    sub ax, 0200h       ; Subtract an immediate constant (e.g., 0x0200 or 512) from AX

    ; Now AX holds the result of num1 - 0x0200

    mov ah, 4ch         ; Terminate program (DOS interrupt)
    int 21h

end start               ; Set 'start' as the program entry point
