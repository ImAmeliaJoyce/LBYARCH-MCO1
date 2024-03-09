; Abenoja, Amelia Joyce L.      S17
; Labarrete, Lance Dessmond D.  S17

; --------------------------
%include "io64.inc"

section .text
global main
main:
    ;Asks for user input, an unsigned decimal
    ;maximum num: 2^(63-1) = 18446744073709551615
    ;minimum num: 0 or 1?
    GET_UDEC 8, RAX
    MOV RBX, RAX        ; copy the original input
    
    ;Check if the input is odd or even
    MOV RCX, 2
    MOV RDX, 0
    DIV RCX
    
    PRINT_STRING "RAX: "
    PRINT_DEC 8, RAX    ; stores the output
    NEWLINE
    PRINT_STRING "RDX: "          
    PRINT_DEC 8, RDX    ; stores the remainder
    NEWLINE
    PRINT_STRING "RCX: "
    PRINT_DEC 8, RCX    ; holds the divisor
    NEWLINE
    
    CMP RDX, 1
    JE ODD  ; if odd, jump to odd function
    
    ; if even, divide it by two
    ; STORE THE OUTPUT EARLIER TO RBX
    MOV RBX, RAX
    PRINT_STRING "EVEN RAX: "
    PRINT_DEC 8, RAX
    NEWLINE
    PRINT_STRING "EVEN RBX: "
    PRINT_DEC 8, RBX
    NEWLINE
    
    
ODD:
    ; triple it and add 1
    MOV RAX, RBX
    MOV RCX, 3
    MOV RDX, 0x0000_0000_0000_0000 ; contains the higher order of 64-bits
    MUL RCX
    INC RAX
    
    PRINT_STRING "ODD RAX: "
    PRINT_DEC 8, RAX
    
    
    ;NEWLINE
    ;PRINT_STRING "Sequence: "
    
    
OUTPUT:
    ;PRINT_UDEC 8, RAX
    ;PRINT_STRING ", "
    JMP FINALLY
    
FINALLY:

    xor rax, rax
    ret