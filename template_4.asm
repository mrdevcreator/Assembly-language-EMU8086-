.MODEL SMALL
.STACK 100H
.DATA                          
    MSG DW "Maximum Number is: $" 
   
.CODE  
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        MOV CX,5
 
        
        INPUT:
        MOV AH,1
        INT 21H
        MOV AH,0
        PUSH AX
        LOOP INPUT
        
        
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13 
        INT 21H
        
        
        
        
        
        MOV CX,4
        POP DX
        MOV BL,DL
        
        OUTPUT: 
        POP DX
        CMP DL,BL
        JGE IF
        JMP ELSE
        IF:
        MOV BL,DL
        ELSE:
 
       
        LOOP OUTPUT
        
        
        MOV AH,9
        LEA DX,MSG
        INT 21H  
        
        
        MOV AH,2
        MOV DL,BL
        INT 21H
        
        
       
         

        
        ; YOUR CODE ENDS HERE
        
        END:
        
        MOV AX, 4C00H
        INT 21H 
        
    MAIN ENDP
    END MAIN                   