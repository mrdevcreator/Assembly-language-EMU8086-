.MODEL SMALL
.STACK 100H
.DATA 
    LETTERS DB '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ$'
    B DB ?
    C DW ?
    BASE_MSG DB 'Please enter the base for conversion. Press Enter for single digit base:$'
    BASE_MSG2 DB 'Please enter the base to convert to. Press Enter for single digit base:$'
    LENGHTH_MSG DB 'Please enter the length of digits you want to convert:$'
    INPUT_MSG DB 'Enter your input form MSB to LSB one by one:$'
    INVALID_MSG  DB 'Invalid base,base should be between(2-36)$'
    INVALID_INPUT_MSG DB 'Input range is out of the base range please start againg!!$' 
    ANS_MSG DB 'Ans:$'
    BASE_FROM DW ?
    BASE_TO DW ?
    num_length DW ? 
    POWER1 DW ?
    POWER2 DW ?
    result DW ?
    FIRST_CHAR DB ?
    SECOND_CHAR DB ? 
    
.CODE  
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX

        MOV AH,9
        LEA DX,BASE_MSG
        INT 21H
        
        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H 


        MOV AH,1 
        INT 21H
        SUB AL,30H
        MOV AH,0
        MOV FIRST_CHAR,AL
        MOV AH,1 
        INT 21H
        CMP AL,0dh 
        JE  SINGLE
        SUB AL,30H
        MOV AH,0
        MOV SECOND_CHAR,AL
        CMP SECOND_CHAR,0dh
        
        DOUBLE:
        MOV AX,0
        MOV AL,FIRST_CHAR 
        MOV BL,10 
        MUL BL
        MOV CX,AX
        MOV AX,0
        MOV AL,SECOND_CHAR
        ADD CX,AX
        MOV BASE_FROM, CX   
        MOV AX,BASE_FROM
        JMP SKIPS
       
        SINGLE:    
        mov CL,FIRST_CHAR
        MOV CH,0
        MOV BASE_FROM, CX   
        MOV AX,BASE_FROM 
          
        SKIPS:
        
        CMP AX,2
        JL  INVALID
        CMP AX,36
        JG  INVALID
        JMP GO_ON 
       
        INVALID:
            MOV AH,9
            LEA DX,INVALID_MSG
            INT 21H
            JMP LAST


        GO_ON:
        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        
        
        MOV AH,9
        LEA DX, LENGHTH_MSG
        INT 21H
        
        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        
        
        ;TAKE THE LENGTH OF THE NUMBER 
        MOV AH,1
        INT 21H
        MOV AH, 0
        SUB AL, 30H
        MOV num_length, AX
        MOV POWER2,AX
        
        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
                                
                                
        MOV AH,9
        LEA DX, INPUT_MSG
        INT 21H
        
        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        
        ;EVERY TIME TAKE ONE NUMBER AND CALCULATE
        MOV CX, num_length
        MOV BX, 0 ; Initialize BX to store the result
        
        INPUT:
        MOV AH,1
        INT 21H
        SUB AL,30H
        MOV B, AL 
        MOV DX, 0
        MOV BL,B
        
        CMP BL,0
        JE  ZERO
        ADD BL,30H
        
        LEA SI, LETTERS
        
        ;FIND THE INDEX FROM THE LETTERS
        START: 
            CMP BL,[SI]
            JE LOOP1
            INC SI
            INC DX
            MOV C,DX
            JMP START
        
        LOOP1:
        MOV BX,C
        MOV DX, BASE_FROM
        CMP BX,DX
        JGE  INVALID_INPUT
        JMP VALID_INPUT
        
        INVALID_INPUT:
           MOV AH, 2
           MOV DL,10
           INT 21H
           MOV DL,13
           INT 21H
           MOV AH,9
           LEA DX,INVALID_INPUT_MSG
           INT 21H
           JMP LAST
        
        VALID_INPUT:
        
        MOV AX, 1 ; Initialize AX to 1 for power calculation
        MOV BX,POWER2
        DEC BX 
        
        POWER:
            MOV DX,BASE_FROM ; Set loop count to the input base
            CMP BX,0
            JE POWER_EXIT
            MUL DX ; AX = AX * DX
            DEC BX ; Decrement the loop counter
            JNZ POWER ; Jump to POWER if CX is not zero
            
        POWER_EXIT: 
        MOV BX,POWER2
        DEC BX
        MOV POWER2,BX
        MOV BX,0   
        
        ; AFTER GETTING THE POWER OF THE BASE MULTIPLY IT WITH THE INDEX 
        MOV POWER1, AX ; Store the result in POWER1
        
        MOV AX, POWER1
        MOV DX,C
        MUL DX ; Multiply AX by the current digit value
        MOV BX,0
        MOV BX,result
        ADD BX, AX ; Add the result to BX
        MOV result,BX
        JMP EXIT
        
        ZERO:
        MOV BX,POWER2
        DEC BX
        MOV POWER2,BX
        
        EXIT:
        
        LOOP INPUT ; Continue loop for all digits 
        

        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H  
        
        
        ; TAKE THE BASE TO WHICH THE DECIMAL NUMBER WILL CONVERT 
        MOV AH, 9
        LEA DX, BASE_MSG2
        INT 21H 
        MOV AH, 2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H

        MOV FIRST_CHAR,0
        MOV SECOND_CHAR,0

        MOV AH,1 
        INT 21H
        SUB AL,30H
        MOV AH,0
        MOV FIRST_CHAR,AL
        MOV AH,1 
        INT 21H
        CMP AL,0dh 
        JE  SINGLE1
        SUB AL,30H
        MOV AH,0
        MOV SECOND_CHAR,AL
        CMP SECOND_CHAR,0dh 

        DOUBLE1:
        MOV AX,0
        MOV AL,FIRST_CHAR 
        MOV BL,10 
        MUL BL
        MOV CX,AX
        MOV AX,0
        MOV AL,SECOND_CHAR
        ADD CX,AX
        MOV BASE_TO, CX   
        MOV AX,BASE_TO
        JMP SKIPS1
       
        SINGLE1:    
        mov CL,FIRST_CHAR
        MOV CH,0
        MOV BASE_TO, CX   
        MOV AX,BASE_TO 
          
        SKIPS1: 
        CMP AX,2
        JL  INVALID1
        CMP AX,36
        JG  INVALID1
        JMP GO_ON1 
       
        INVALID1:
            MOV AH,9
            LEA DX,INVALID_MSG
            INT 21H
            JMP LAST
            
        GO_ON1:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        MOV AX, result
        MOV BX,BASE_TO
        MOV BX,0
        

        
        DIV_LOOP:
            MOV DX, 0
            MOV BX, BASE_TO
            DIV BX; AX = AX / BASE_TO, DX = Remainder
            
            PUSH DX ; Push remainder onto the stack
            
            CMP AX, 0 ; Check if quotient is zero
            JNZ DIV_LOOP ; If not, continue division
          
        MOV AH, 9
        LEA DX, ANS_MSG
        INT 21H 
        MOV AH, 2
        ; Output the result from the stack
        POP_LOOP:
            POP DX ; Pop remainder from the stack
            
            ADD DL, 30H ; Convert remainder to ASCII
            CMP DL, '9'
            JLE SKIP
            
            ADD DL, 7 ; Adjust for letters A-Z
            SKIP:
            
            MOV AH, 2 ; Print character
            MOV DL, DL
            INT 21H
            
            CMP SP, 100H ; Check if stack pointer reached initial position
            JNZ POP_LOOP
            JMP LAST
            

        LAST:

        MOV AH, 4CH
        INT 21H 
        
    MAIN ENDP
    END MAIN 
