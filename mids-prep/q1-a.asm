.model small            ; Use the small memory model (code <64K, data <64K)
.stack 100h             ; Allocate 256 bytes for the stack

.data
    number dw "123456"    ; Declare a 16-bit number (note: max is 65535 for 16-bit, so 123456 will be truncated to 57920)
    digits db 6 dup(?)  ; Reserve 6 bytes for storing ASCII digits

.code
start:
    mov ax, @data       ; Load the address of the data segment into AX
    mov ds, ax          ; Set DS (Data Segment register) to point to the data segment

    ; Step 1: Load the number into AX for processing
    mov ax, number      ; Move the value of 'number' into AX
    xor cx, cx          ; Clear CX to use it as a digit counter
    mov si, offset digits ; Load address of 'digits' array into SI
    add si, 5           ; Move SI to the last position (digits[5]) to store digits from right to left

    ; Step 2: Convert number to ASCII digits (in reverse order)
convert_loop:
    xor dx, dx          ; Clear DX before division (since DIV uses DX:AX)
    mov bx, 10          ; Set divisor to 10 for base-10 conversion
    div bx              ; Divide AX by BX ? Quotient in AX, Remainder in DX

    add dl, '0'         ; Convert remainder (0–9) to ASCII by adding ASCII value of '0'
    mov [si], dl        ; Store ASCII digit in digits[si]
    dec si              ; Move SI one position left for next digit
    inc cx              ; Increment digit count
    cmp ax, 0           ; Check if quotient is zero (all digits processed)
    jne convert_loop    ; If not zero, continue loop

    ; Step 3: Pad with leading zeros if fewer than 6 digits
    mov bx, 6           ; We want exactly 6 digits
    sub bx, cx          ; Subtract number of actual digits from 6 ? how many leading zeros needed
    mov al, '0'         ; ASCII '0' character for padding
leading_zeros:
    cmp bx, 0           ; Check if padding is done
    je print_digits     ; If yes, jump to printing stored digits
    mov dl, al          ; Move '0' into DL for printing
    mov ah, 02h         ; DOS interrupt function 02h: print character in DL
    int 21h             ; Call DOS interrupt to print character
    dec bx              ; Decrease count of remaining padding zeros
    jmp leading_zeros   ; Repeat loop

    ; Step 4: Print the digits stored in memory (now in correct order)
print_digits:
    inc si              ; SI was last used at si–1, so increment to first digit
    mov cx, 6           ; We always print 6 digits
print_loop:
    mov dl, [si]        ; Load next ASCII digit into DL
    mov ah, 02h         ; DOS function to print character
    int 21h             ; Print the character
    inc si              ; Move to next digit
    loop print_loop     ; Repeat 6 times

    ; Step 5: Exit the program
    mov ah, 4Ch         ; DOS function 4Ch: terminate program
    int 21h             ; Call DOS interrupt to exit
end start               ; Mark the end of the program
