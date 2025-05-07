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

    ; Simulate R1 = 9 * B
    MOV AL, B
    MOV BL, 9
    MUL BL
    MOV CL, AL      ; R1 = 9*B

    ; Simulate R2 = A + R1
    ADD CL, A       ; R2 = A + 9*B
    ADD CL, C       ; R2 = A + 9*B + C

    ; Simulate R3 = D / E
    MOV AL, D
    MOV BL, E
    DIV BL
    MOV DL, AL

    ; Simulate R4 = R3 * F
    MOV BL, F
    MUL BL
    MOV AL, AL

    ; Simulate R5 = R4 * 4
    MOV BL, 4
    MUL BL

    ; Final: R6 = R2 - R5
    SUB CL, AL
    MOV G, CL

    MOV AH, 4CH
    INT 21H
