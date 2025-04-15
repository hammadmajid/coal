.model small
.stack 100h

.data
rollNo db '123456!', '$'   ; '$' is the string terminator for INT 21h AH=09h

.code
main:
    mov ax, @data       ; Initialize DS register
    mov ds, ax

    mov ah, 09h         ; Function to display string
    mov dx, offset rollNo
    int 21h             ; Call DOS interrupt

    mov ah, 4Ch         ; Exit program
    int 21h

end main
