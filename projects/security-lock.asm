include emu8086.inc  ; Include standard macros and definitions for EMU8086 assembler

.MODEL SMALL  ; Define memory model as SMALL (separate code and data segments, max 64KB each)
.DATA   
        ; Constants and Messages
        SIZE EQU 10  ; Define the number of valid IDs and passwords
        HEAD DB '________________Security lock________________','$' ; Header message
        MSG1 DB 13, 10, 'Enter your ID:$'  ; Prompt for user ID input
        MSG2 DB 13, 10, 'Enter your Password:$'  ; Prompt for password input
        MSG3 DB 13, 10, 'ERROR ID not Found!$'  ; Error message for invalid ID
        MSG4 DB 13, 10, 'Wrong Password! Access denied$'  ; Error message for incorrect password
        MSG5 DB 13, 10, 'Correct! Welcome to the Safe$'  ; Success message for correct login
        MSG6 DB 13, 10, 'Too Long password!$'  ; Error message for overly long passwords
        
        ; Temporary storage for user inputs
        TEMP_ID DW 1 DUP(?),0  ; Buffer for storing user ID input
        TEMP_Pass DB 1 DUP(?)  ; Buffer for storing user password input
        
        ; Compute size of the ID and password fields
        IDSize = $-TEMP_ID  ; Calculate size of ID input field
        PassSize = $-Temp_Pass  ; Calculate size of password input field
        
        ; List of predefined valid IDs
        ID  DW 'A150', 'B255', 'CE20', 'BB71', 'D111', 'E500', 'F432', 'EC12', '5321', '9876' 
        
        ; Corresponding passwords for the IDs
        Password DB 1, 2, 3, 4, 7, 10, 11, 13, 12, 14

.CODE
MAIN        PROC
            MOV AX,@DATA   ; Load data segment address into AX
            MOV DS,AX      ; Move AX into DS to initialize the data segment
            MOV AX,0000H   ; Clear AX register (resetting flags)
            
; Display Title
Title:      LEA DX,HEAD  ; Load address of HEAD message into DX
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt

; Prompt user for ID
ID_PROMPT:  LEA DX,MSG1  ; Load address of MSG1 into DX (prompt for ID)
            MOV AH,09H    ; DOS interrupt to print string
            INT 21H       ; Call DOS interrupt
            
; Accept user ID input
ID_INPUT:   MOV BX,0  ; Initialize BX to 0 (used as index)
            MOV DX,0  ; Clear DX (used as buffer index)
            LEA DI,TEMP_ID  ; Load address of TEMP_ID buffer into DI
            MOV DX,IDSize  ; Move size of ID field into DX
            CALL get_string  ; Call function to get user input string
            
; Check if entered ID is valid
CheckID:    MOV BL,0   ; Initialize BL as counter (index for ID list)
            MOV SI,0   ; Initialize SI to point to the ID list

AGAIN:      MOV AX,ID[SI]  ; Load current ID into AX from the list
            MOV DX,TEMP_ID  ; Load user input ID into DX
            CMP DX,AX       ; Compare user input ID with current valid ID
            JE  PASS_PROMPT ; If match found, proceed to password input
            INC BL          ; Increment ID index counter
            ADD SI,4        ; Move to next ID (each ID is 4 bytes long)
            CMP BL,SIZE     ; Check if all IDs have been checked
            JB  AGAIN       ; If not, continue checking next ID
            
; If no match, show error and ask for ID again
ERRORMSG:   LEA DX,MSG3  ; Load error message for invalid ID
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt
            JMP ID_PROMPT  ; Restart the ID input process
              
; If ID is found, ask for password
PASS_PROMPT:LEA DX,MSG2  ; Load address of MSG2 (password prompt)
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt
            
; Accept user password input
Pass_INPUT: CALL   scan_num  ; Call function to accept numeric input (password)
            CMP    CL,0FH    ; Compare entered password length with max allowed (0Fh = 15)
            JAE    TooLong   ; If too long, jump to TooLong error message
            MOV    BH,00H    ; Clear BH (used for index calculation)
            MOV    DL,Password[BX]  ; Load correct password for corresponding ID
            CMP    CL,DL     ; Compare entered password with correct password
            JE     CORRECT   ; If match, jump to success message
            
; If password is incorrect, show error message and restart
INCORRECT:  LEA DX,MSG4  ; Load error message for wrong password
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt
            JMP ID_PROMPT ; Restart ID input process
            
; If password is correct, display success message
CORRECT:    LEA DX,MSG5  ; Load success message
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt
            JMP Terminate  ; Jump to program termination
            
; Handle case where password is too long
TooLong:    LEA DX,MSG6  ; Load error message for long password
            MOV AH,09H   ; DOS interrupt to print string
            INT 21H      ; Call DOS interrupt
            JMP PASS_PROMPT ; Restart password input process
                            
; Define essential functions for input handling
DEFINE_SCAN_NUM  ; Macro to define scan_num function (for numeric input)
DEFINE_GET_STRING  ; Macro to define get_string function (for string input)

; Program termination
Terminate:  
END MAIN    ; Mark end of program execution
