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

    ; (A + 9*B + C)
    MOV AL, B
    MOV BL, 9
    MUL BL          ; AL = 9*B
    PUSH AX         ; Push 9*B

    MOV AL, A
    ADD AL, C       ; AL = A + C
    PUSH AX         ; Push A + C

    POP BX          ; BX = A + C
    POP AX          ; AX = 9*B
    ADD AL, BL      ; AL = (A + 9*B + C)

    PUSH AX         ; Push result of (A + 9*B + C)

    ; (D / E * F)
    MOV AL, D
    MOV BL, E
    DIV BL          ; AL = D / E

    MOV BL, F
    MUL BL          ; AL = (D / E) * F
    MOV BL, 4
    MUL BL          ; AL = 4*(D / E * F)

    POP BL          ; BL = (A + 9*B + C)
    SUB BL, AL      ; BL = final result
    MOV G, BL

    MOV AH, 4CH
    INT 21H
