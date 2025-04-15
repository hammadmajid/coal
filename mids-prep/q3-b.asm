.model small         ; Define the memory model as small (code and data fit in one segment)
.stack 100h          ; Reserve 256 bytes (100h) of stack space

.data                ; Start of data segment (not used here but included for structure)

.code                ; Start of code segment
start:               ; Entry point label

    mov bl, 5        ; Load the first 8-bit number (5) into register BL
    mov cl, 3        ; Load the second 8-bit number (3) into register CL

    cmp bl, cl       ; Compare BL and CL: sets flags based on (BL - CL)
    je  equal        ; Jump to 'equal' label if BL == CL (Zero Flag is set)
    ja  greater      ; Jump to 'greater' if BL > CL (Unsigned comparison, CF=0 and ZF=0)
    jb  less         ; Jump to 'less' if BL < CL (Unsigned comparison, CF=1)

equal:               ; Label for equal case
    mov al, 0        ; Set AL to 0 if the numbers are equal
    jmp done         ; Jump to done to skip other conditions

greater:             ; Label for greater than case
    mov al, 1        ; Set AL to 1 if BL > CL
    jmp done         ; Jump to done

less:                ; Label for less than case
    mov al, 2        ; Set AL to 2 if BL < CL

done:                ; Label marking the end of comparison
    ; AL now holds the result:
    ; 0 = equal, 1 = greater, 2 = less

    mov ah, 4ch      ; Prepare to exit program (DOS function 4Ch)
    int 21h          ; Interrupt 21h: Terminate program and return control to DOS

end start            ; Mark the end of the program and set 'start' as the entry point
