.MODEL SMALL
.STACK 100H
.DATA
A DB 2
B DB 3
C DB 4
D DB 8
E DB 2
F DB 2
G DB ?
.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Compute 9 * B
    MOV AL, B
    MOV BL, 9
    MUL BL          ; AL = 9*B

    ; Add A
    ADD AL, A

    ; Add C
    ADD AL, C       ; AL = A + 9*B + C
    MOV DL, AL      ; Save result in DL

    ; Compute D / E
    MOV AL, D
    MOV BL, E
    DIV BL          ; AL = D / E

    ; Multiply by F
    MOV BL, F
    MUL BL          ; AL = (D/E)*F

    ; Multiply by 4
    MOV BL, 4
    MUL BL          ; AL = 4*(D/E*F)

    ; Subtract
    SUB DL, AL
    MOV G, DL

    MOV AH, 4CH
    INT 21H
