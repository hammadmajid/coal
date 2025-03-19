.model small           ; Use small memory model (code & data in one segment)
.stack 100h            ; Define 256-byte stack

.data
    num_subj_msg db 'Enter number of subjects: $'
    obt_marks  db 13,10, 'Enter your obtained marks (two digits): $'

    msg_aone   db 13,10, 'Grade : A-One $'
    msg_a      db 13,10, 'Grade : A $'
    msg_b      db 13,10, 'Grade : B $'
    msg_c      db 13,10, 'Grade : C $'
    msg_d      db 13,10, 'Grade : D $'
    msg_f      db 13,10, 'Grade : F $'

.code

main proc
    mov ax,@data
    mov ds,ax
    mov es,ax

    ; Ask for the number of subjects.
    mov ah,9
    lea dx, num_subj_msg
    int 21h

    ; Read one character (assumes a single-digit number)
    mov ah,1
    int 21h
    sub al,'0'      ; Convert ASCII to numeric
    mov cl,al      ; Loop counter = number of subjects

subject_loop:
    cmp cl,0
    je finish

    ; Ask for obtained marks.
    mov ah,9
    lea dx, obt_marks
    int 21h

    ; Input routine: Read two characters.
    mov ah,1         ; Read tens digit.
    int 21h
    mov bh,al       ; Store tens digit in BH.

    mov ah,1         ; Read ones digit.
    int 21h
    mov bl,al       ; Store ones digit in BL.

    ; Determine grade based on the tens digit (BH).
    cmp bh,'9'
    je grade_aone
    cmp bh,'8'
    je grade_a
    cmp bh,'7'
    je grade_b
    cmp bh,'6'
    je grade_c
    cmp bh,'5'
    je grade_d
    jmp grade_f

grade_aone:
    mov ah,9
    lea dx, msg_aone
    int 21h
    jmp next_subject

grade_a:
    mov ah,9
    lea dx, msg_a
    int 21h
    jmp next_subject

grade_b:
    mov ah,9
    lea dx, msg_b
    int 21h
    jmp next_subject

grade_c:
    mov ah,9
    lea dx, msg_c
    int 21h
    jmp next_subject

grade_d:
    mov ah,9
    lea dx, msg_d
    int 21h
    jmp next_subject

grade_f:
    mov ah,9
    lea dx, msg_f
    int 21h

next_subject:
    dec cl
    jmp subject_loop

finish:
    mov ah,4Ch         ; Terminate process.
    int 21h

main endp
end main
