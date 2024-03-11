; Abenoja, Amelia Joyce L.      S17
; Labarrete, Lance Desmond D.  S17

; --------------------------

%include "io64.inc"

section .data
INPUT dw 0
ENTER_KEY db 0
RESPO db 0

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    
    mov qword[INPUT], 0
    mov byte[ENTER_KEY], 0
    
    ; Input positive integer    
    PRINT_STRING "Input: "
    GET_DEC 8, [INPUT]
    
    mov RAX, [INPUT]
 
    ; Copy the original input to EBX
    mov RBX, RAX

    GET_CHAR [ENTER_KEY]    ; For enter key
    
    cmp RAX, 0
    JG START
    
    ; Check if input is a negative number
    cmp qword[INPUT], 0
    JL ERROR_NEGATIVE
   
    JMP ERROR_INVALID


START:
    PRINT_STRING "Sequence: "
    JMP SEQUENCE_LOOP

    ; Continues sequence until the number is 1
SEQUENCE_LOOP:
    ; Output the current term in the sequence
    PRINT_DEC 8, RBX
    
    ; Check if the current term is 1
    CMP RBX, 1
    JE FINALLY  ; if 1, jump to finally
    
    ; If the current term is not 1, print the comma
    PRINT_STRING ", "
    
    ; Check if the current term is even
    MOV RAX, RBX
    MOV RCX, 2
    MOV RDX, 0
    DIV RCX
    
    CMP RDX, 0
    JE EVEN  ; if even, jump to even section
    ; Else, it goes directly to ODD
    
            
ODD:
    ; triple it and add 1
    MOV RAX, RBX
    MOV RCX, 3
    MOV RDX, 0  ; contains the higher order of 64-bits
    MUL RCX
    INC RAX
    
    ; Update RBX to the new term
    MOV RBX, RAX
    JMP SEQUENCE_LOOP  ; Continue with the next term in the sequence


EVEN:
    ; if even, divide it by two
    MOV RAX, RBX
    SHR RAX, 1
    
    ; Update RBX to the new term
    MOV RBX, RAX
    JMP SEQUENCE_LOOP  ; Continue with the next term in the sequence


FINALLY: 
    ; Prompt the user whether to continue
    NEWLINE
    PRINT_STRING "Do you want to continue (Y/N)? "
    GET_CHAR [RESPO]
    NEWLINE
    
    CMP byte[RESPO], 'Y'    ; If 'Y', jump to start (input prompt)
    JE main         

    CMP byte[RESPO], 'N'    ; If 'N', jump to exit the program
    JE EXIT
    
    JMP ERROR_INVALID       ; Any invalid errors


ERROR_NEGATIVE:
    ; Print error message for negative input
    NEWLINE
    PRINT_STRING "Error: negative number input"
    jmp CLEAR_JUNK
    ;JMP FINALLY


ERROR_INVALID:
    ; Print error message for invalid choice in continuing the program
    NEWLINE
    PRINT_STRING "Error: Invalid input"    
    jmp CLEAR_JUNK
    ;JMP FINALLY
    
        
CLEAR_JUNK:
    GET_CHAR [ENTER_KEY]
    cmp byte[ENTER_KEY], 10  ; Check if the character read is a newline
    je FINALLY            ; If newline, go back to input prompt
    jmp CLEAR_JUNK
    

                 
EXIT: 
    ; Exit the program
    xor rax, rax
    ret
