name "hex-bin" org 100h      ; set Program name and origin point at 100h

mov al, 00000101b            ; Load binary value 101 into AL register
mov bl, 0ah                  ; Load hexadecimal value A into BL register
mov cl, 10o                  ; Load octal value 10 into CL register

add al, bl                   ; Add BL to AL
sub al, cl                   ; Subtract CL from AL
mov bl, al                   ; Copy result from AL to BL

mov cx, 8                    ; Set loop counter to 8

print:                       ; Label for printing loop
    mov ah, 2               ; Set AH to 2 (print character function)
    mov dl, '0'             ; Set DL to '0' character
    test bl, 10000000b      ;
    jz zero                 ; If bit is 0, jump to zero label
    mov dl, '1'             ; If bit is 1, change DL to '1' character

zero:                       ; Label for printing zero bit
    int 21h                ; Call interrupt to print character in DL
    shl bl, 1              ; Shift BL left by 1
    loop print             ;

mov dl, 'b'                 ; Load 'b' character into DL
int 21h                     ; Print the 'b' character
mov ah, 0                   ; Set AH 0
int 16h
ret                         ;return
