include emu8086.inc  ; Include standard macros and definitions for EMU8086 assembler

.MODEL SMALL        ; Define memory model as SMALL
.DATA   
        ; Constants and Messages
        HEAD    DB '________________Security lock________________','$'  ; Header message
        MSG1    DB 13,10, 'Enter your ID:$'      ; Prompt for user ID input
        MSG2    DB 13,10, 'Enter your Password:$'  ; Prompt for password input
        MSG3    DB 13,10, 'ERROR: ID not Found!$'   ; Error message for invalid ID
        MSG4    DB 13,10, 'Wrong Password! Access denied$' ; Error message for incorrect password
        MSG5    DB 13,10, 'Correct! Welcome to the Safe$'  ; Success message for correct login
        MSG6    DB 13,10, 'Too Long password!$'     ; Error message for overly long password
        
        ; Temporary storage for user inputs
        TEMP_ID DB 5 DUP(?),0   ; Buffer for storing user ID input (4 characters + terminator)
        ; (TEMP_Pass not needed because password is scanned as a number)
        
        ; Predefined valid credentials (only one each)
        ValidID DB 'A1'       ; Only valid ID (2 characters)
        ValidPass DB 12        ; Only valid password (numeric)

.CODE
MAIN    PROC
        MOV AX,@DATA      ; Load data segment address into AX
        MOV DS,AX         ; Initialize the data segment

; Display Title
Title:  LEA DX,HEAD      ; Load address of HEAD message into DX
        MOV AH,09H      ; DOS interrupt to print string
        INT 21H

; Prompt user for ID
ID_PROMPT:
        LEA DX,MSG1     ; Load address of MSG1 prompt
        MOV AH,09H      ; DOS interrupt to print string
        INT 21H

; Accept user ID input
ID_INPUT:
        LEA DI, TEMP_ID ; Load address of TEMP_ID buffer into DI
        MOV DX, 3       ; Maximum number of characters to read (including terminator)
        CALL get_string ; Call macro to get string input

; Check if entered ID is valid (compare with ValidID)
        LEA SI, TEMP_ID ; Point SI to the entered ID
        LEA DI, ValidID ; Point DI to the valid ID
        MOV CX, 2       ; Number of characters to compare
CompareID:
        LODSB           ; Load byte from [SI] into AL and increment SI
        CMP AL, [DI]    ; Compare with corresponding byte in ValidID
        JNE ERRORMSG    ; If not equal, jump to error message
        INC DI          ; Move to next character in ValidID
        LOOP CompareID  ; Repeat for 2 characters

; If the ID matches, prompt for password
PASS_PROMPT:
        LEA DX,MSG2     ; Load address of MSG2 (password prompt)
        MOV AH,09H      ; DOS interrupt to print string
        INT 21H

; Accept user password input (numeric)
Pass_INPUT:
        CALL scan_num   ; Call function to accept numeric input (password stored in CL)
        CMP CL,0FH      ; Check if entered password length is too long (max allowed = 15)
        JAE TooLong     ; If too long, jump to error handling for password length
        MOV DL, ValidPass ; Load the valid password into DL
        CMP CL, DL      ; Compare entered password (in CL) with valid password (in DL)
        JE  CORRECT     ; If equal, password is correct

; If password is incorrect, show error and restart ID input
INCORRECT:
        LEA DX,MSG4     ; Load error message for wrong password
        MOV AH,09H      ; DOS interrupt to print string
        INT 21H
        JMP ID_PROMPT   ; Restart from ID input

; If password is correct, display success message
CORRECT:
        LEA DX,MSG5     ; Load success message
        MOV AH,09H      ; DOS interrupt to print string
        INT 21H
        JMP Terminate   ; End program

; Handle case where password is too long
TooLong:
        LEA DX,MSG6     ; Load error message for long password
        MOV AH,09H      ; DOS interrupt to print string
        INT 21H
        JMP PASS_PROMPT ; Re-prompt for password       
        
        ; If no match, show error and ask for ID again
ERRORMSG:   LEA DX,MSG3  ; Load error message for invalid ID
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt
            JMP ID_PROMPT  ; Restart the ID input process


; Define essential functions for input handling
DEFINE_SCAN_NUM     ; Macro to define scan_num function (for numeric input)
DEFINE_GET_STRING   ; Macro to define get_string function (for string input)

Terminate:
        END MAIN        ; End of program execution
