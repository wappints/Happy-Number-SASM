; Yeohan Norona, S12
; MOST UPDATED VERSION : EVERYTHING WORKS
%include "io-custom.inc"
section .data
choice times 9 db 0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
STARTT:
    cmp cl, 0 
    JNE READ
READ: 
    mov ax, 0
    mov byte [choice], 0x0000
    PRINT_STRING "Input Number: " 
    GET_DEC 2, choice ; x
    mov ax, [choice]
    NEWLINE
    CMP AX, 2560
    JE ERROR
    CMP AX, 0
    JE ERROR 
    CMP AX, 0
    JL ERROR2 
    CMP AX, 255
    JG ERROR2
    MOV CX, AX
    MOV AX, 0 
    MOV AL, CL
    MOV CX, 0
    MOV DX, 0 
    MOV AH, 0  ; remainder  
    MOV DH, 0  ; container
    MOV BH, AL ; sum 
    MOV BL, 10 ; divisor
    MOV CL, 0 ; count
    PRINT_STRING "Iterations: "
    PRINT_UDEC 1, BH
    PRINT_STRING ", "
    MOV BH, 0    
LOOP1:  
    
    DIV BL ; 123 / 10  
    MOV DH, AH ; -> 3
    MOV CH, AL ; -> 12 
    CMP AH, 0 
    JE MULTIPLY
    MOV AL, AH ; -> 3
    
MULTIPLY:
    CMP AL, 9 
    JA LOOP1
    MUL AL    
    ADD BH, AL 
    MOV AL, CH

    CMP DH, 0 
    JNE LOOP1
    
    MOV AL, BH
    MOV BH, 0
    
    PRINT_UDEC 1, AL
    INC CL

    CMP AL, 1
    JE SUCCESS
    
DESTROY:
    CMP CL, 19
    JE FAIL

CONTINUE:
    PRINT_STRING ", "   
    CMP AL, 1 
    JE SUCCESS
    CMP CL, 19
    JE FAIL
    CMP AL, 9
    JA LOOP1
    JMP MULTIPLY
    
SUCCESS: 
    NEWLINE
    NEWLINE
    PRINT_STRING "Happy Number: Yes"
        GET_STRING [choice], 8
    NEWLINE
    NEWLINE
    MOV AL, 0
    JMP PROMPT
    RET

    
SETTER:
    MOV CL, 19
    JMP DESTROY
    
FAIL:
    NEWLINE
    NEWLINE
    PRINT_STRING "Happy Number: No"
        GET_STRING [choice], 8
    NEWLINE  
    NEWLINE  
    MOV AL, 0
    JMP PROMPT
    RET

ERROR: 
  
    PRINT_STRING "Error: Invalid Input" 
    GET_STRING [choice], 8
    JMP TRIAL
SPECIALERROR:    
    PRINT_STRING "Error: Invalid Input" 
TRIAL:
    NEWLINE
    NEWLINE
    JMP PROMPT
    ret
    
PROMPT:  
NEWLINE
    PRINT_STRING "Do you want to continue (Y/N)? "
    GET_STRING [choice], 8
    NEWLINE
    MOV AL, [choice]
    CMP AL, 0
    JE PROMPT
    CMP AL, 0x59
    JE STARTT
    NEWLINE
    CMP AL, 0x4E 
    JE ENDD
    CMP AL, 0x0a
    JE ERROR3
    JMP SPECIALERROR
ENDD:
    ret
    
ERROR2: 
    PRINT_STRING "Error: Out of Range" 

    NEWLINE
    NEWLINE
    GET_STRING [choice], 8
    JMP PROMPT
    RET 
    
ERROR3: 
    PRINT_STRING "Error: Null Input" 

    NEWLINE
    JMP PROMPT
    XOR EAX, EAX
    RET 
    
    
    
    
    
    
    
    