org 100h               ; COM program starts at offset 100h (required for .COM format)

mov cx, 1              ; Initialize outer loop counter to 1 (number of '*' to print on the first line)

outer_loop:
  mov dl, '*'          ; Load DL with ASCII code of '*' to print
  mov si, cx           ; Copy CX to SI (number of '*' to print on this line)

inner_loop:
  mov ah, 02h          ; Set function 02h (display character in DL) for INT 21h
  int 21h              ; DOS interrupt to print character in DL
  dec si               ; Decrease SI (count of '*' left to print)
  jnz inner_loop       ; If SI is not zero, repeat inner loop

  ; Print newline
  mov dl, 13           ; Load DL with carriage return (CR)
  mov ah, 02h          ; Set function 02h again
  int 21h              ; Print CR (move to beginning of line)
  mov dl, 10           ; Load DL with line feed (LF)
  mov ah, 02h          ; Set function 02h again
  int 21h              ; Print LF (move to next line)

  inc cx               ; Increment line count (number of '*' to print)
  cmp cx, 6            ; Compare CX to 6 (we want to print up to 5 lines)
  jne outer_loop       ; If not equal to 6, repeat outer loop

ret                    ; Return from program (end of execution)
