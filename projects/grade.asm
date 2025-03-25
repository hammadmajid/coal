.model small           ; Use the small memory model: both code and data are in one segment.
.stack 100h            ; Allocate a 256-byte stack (100h in hexadecimal equals 256 in decimal).

.data
    ; Define a message prompt asking for the number of subjects.
    num_subj_msg db 'Enter number of subjects: $'
    ; Define a message prompt asking for obtained marks. A newline (13,10) is added before the text.
    obt_marks  db 13,10, 'Enter your obtained marks (two digits): $'

    ; Define messages for the various grades with a newline at the start.
    msg_aone   db 13,10, 'Grade : A-One $'
    msg_a      db 13,10, 'Grade : A $'
    msg_b      db 13,10, 'Grade : B $'
    msg_c      db 13,10, 'Grade : C $'
    msg_d      db 13,10, 'Grade : D $'
    msg_f      db 13,10, 'Grade : F $'

.code

main proc
    ; Initialize Data Segment Registers
    mov ax,@data     ; Load the address of the data segment into AX.
    mov ds,ax        ; Set DS (Data Segment) register to point to the data segment.
    mov es,ax        ; Set ES (Extra Segment) register to point to the same data segment.

    ; Display prompt for number of subjects
    mov ah,9        ; AH=9 selects DOS function to display a string.
    lea dx, num_subj_msg ; Load the effective address of 'num_subj_msg' into DX.
    int 21h         ; Call DOS interrupt 21h to output the string.

    ; Read number of subjects from user input
    mov ah,1        ; AH=1 selects DOS function to read a character from keyboard.
    int 21h         ; Call DOS interrupt 21h to read one character into AL.
    sub al,'0'      ; Convert the ASCII character in AL to its numeric value.
                    ; (For example, '3' (ASCII 51) minus '0' (ASCII 48) equals 3.)
    mov cl,al      ; Store the numeric value in CL, which will serve as our loop counter.

    ; Loop to process each subject's marks and assign a grade
subject_loop:
    cmp cl,0       ; Compare the loop counter (number of subjects remaining) to 0.
    je finish      ; If CL is zero, all subjects have been processed, so jump to finish.

    ; Prompt for obtained marks for the current subject
    mov ah,9       ; Prepare to display a string again.
    lea dx, obt_marks ; Load the effective address of the 'obt_marks' prompt into DX.
    int 21h        ; Call DOS interrupt 21h to display the obtained marks prompt.

    ; Input routine: Read two characters representing the obtained marks.

    ; Read tens digit of the obtained marks.
    mov ah,1         ; AH=1: DOS function to read a single character.
    int 21h          ; Call DOS interrupt to get the tens digit, stored in AL.
    mov bh,al        ; Move the tens digit into BH for temporary storage.

    ; Read ones digit of the obtained marks.
    mov ah,1         ; Set AH=1 again to read another character.
    int 21h          ; Call DOS interrupt to read the ones digit, stored in AL.
    mov bl,al        ; Move the ones digit into BL for temporary storage.
                     ; Note: Although both digits are read, only the tens digit (in BH)
                     ; is used to determine the grade.

    ; Determine the grade based solely on the tens digit (stored in BH).
    ; The program checks the tens digit character against ASCII codes for '9', '8', etc.
    cmp bh,'9'      ; Compare the tens digit with ASCII '9'.
    je grade_aone   ; If equal, jump to grade_aone (grade A-One).
    cmp bh,'8'      ; Otherwise, compare with ASCII '8'.
    je grade_a      ; If equal, jump to grade_a (grade A).
    cmp bh,'7'      ; Compare with ASCII '7'.
    je grade_b      ; If equal, jump to grade_b (grade B).
    cmp bh,'6'      ; Compare with ASCII '6'.
    je grade_c      ; If equal, jump to grade_c (grade C).
    cmp bh,'5'      ; Compare with ASCII '5'.
    je grade_d      ; If equal, jump to grade_d (grade D).
    ; If none of the above conditions met, default to grade F.
    jmp grade_f

grade_aone:
    ; Display message for grade A-One.
    mov ah,9       ; AH=9 to display a string.
    lea dx, msg_aone ; Load effective address of the A-One message.
    int 21h        ; Call DOS interrupt 21h to output the grade.
    jmp next_subject ; Jump to the next subject processing.

grade_a:
    ; Display message for grade A.
    mov ah,9
    lea dx, msg_a   ; Load effective address of the A grade message.
    int 21h
    jmp next_subject

grade_b:
    ; Display message for grade B.
    mov ah,9
    lea dx, msg_b   ; Load effective address of the B grade message.
    int 21h
    jmp next_subject

grade_c:
    ; Display message for grade C.
    mov ah,9
    lea dx, msg_c   ; Load effective address of the C grade message.
    int 21h
    jmp next_subject

grade_d:
    ; Display message for grade D.
    mov ah,9
    lea dx, msg_d   ; Load effective address of the D grade message.
    int 21h
    jmp next_subject

grade_f:
    ; Display message for grade F.
    mov ah,9
    lea dx, msg_f   ; Load effective address of the F grade message.
    int 21h
    ; No jump here; execution falls through to next_subject after displaying grade F.

next_subject:
    dec cl         ; Decrement the subject counter (CL) by one.
    jmp subject_loop ; Loop back to process the next subject.

finish:
    ; Terminate the program.
    mov ah,4Ch     ; AH=4Ch selects DOS function to exit the program.
    int 21h        ; Call DOS interrupt 21h to terminate the process.

main endp
end main         ; Mark the end of the program with the entry point "main".
