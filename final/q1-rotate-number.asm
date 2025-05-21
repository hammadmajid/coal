org 100h
.stack 100h

.data
    hex1 db 4 dup(?), '$'   ; buffer for original value
    hex2 db 4 dup(?), '$'   ; buffer for converted value
    newline db 13, 10, '$'  ; for printing new line

.code
    ; original number
    mov ax, 8765h
    mov bx, ax              ; store original in BX
    call HexToStr
    lea dx, hex1
    mov ah, 09h
    int 21h

    ; newline
    mov dl, newline
    mov al, 09h
    int 21h

    ; rotate to get 6887h
    mov ax, bx
    ror ax, 8               ; 8768h -> 6887h

    call HexToStr
    lea dx, hex2
    mov ah, 09h
    int 21h

ret

; Converts AX to 4 ASCII hex characters and stores in buffer pointed by DS:DI
; Preserves AX, BX, CX
HexToStr:
    push ax
    push bx
    push cx
    push di

    mov cx, 4
    lea di, hex1
    cmp ax, bx
    jne use_hex2
    lea di, hex1
    jmp convert_loop
use_hex2:
    lea di, hex2

convert_loop:
    rol ax, 4               ; bring next nibble into low 4 bits
    mov bl, al
    and bl, 0Fh             ; isolate nibble
    cmp bl, 9
    jbe num_digit
    add bl, 37h             ; A-F
    jmp store
num_digit:
    add bl, 30h             ; 0–9
store:
    mov [di], bl
    inc di
    loop convert_loop
    mov [di], '$'

    pop di
    pop cx
    pop bx
    pop ax
    ret
