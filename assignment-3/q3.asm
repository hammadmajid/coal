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

    ; Compute 9*B
    MOV AL, B
    MOV BL, 9
    MUL BL          ; AL = 9*B

    MOV DL, AL
    ADD DL, A
    ADD DL, C       ; DL = A + 9*B + C

    ; Compute D / E * F
    MOV AL, D
    MOV BL, E
    DIV BL          ; AL = D / E

    MOV BL, F
    MUL BL          ; AL = (D / E) * F

    MOV BL, 4
    MUL BL          ; AL = 4 * (D / E * F)

    SUB DL, AL      ; DL = result
    MOV G, DL

    MOV AH, 4CH
    INT 21H
