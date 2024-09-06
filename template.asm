.MODEL SMALL
.STACK 100H
.DATA
   G DW "GRATER  $"
   L DW "LESSER  $" 
   
.CODE  
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; YOUR CODE STARTS HERE
        ;MOV AH,1
        ;INT 21H
        ;SUB AL,'0'
        ;MOV CL,AL
;        
;        MOV BL,9
;        MOV BH,7
;        
;        MOV AH,2
;        MOV DL,10
;        INT 21H
;        MOV DL,13
;        INT 21H
;        
;        
;        CMP BH,BL
;        JG IF
;        JMP ELSE  
;        
;
;        
;        IF:
;        MOV AH,9
;        LEA DX,G
;        INT 21H
;        MOV AH,2
;        ADD BH,'0'
;        MOV DL,BH
;        INT 21H
;        JMP EXIT
;        
;        
;        ELSE: 
;        MOV AH,9
;        LEA DX,G
;        INT 21H
;        MOV AH,2
;        ADD BL,'0'
;        MOV DL,BL
;        INT 21H
;        JMP EXIT 

;        MOV AH,2
;        MOV DL,30H
;        
;        
;        START:
;        CMP DL,35H
;        JG EXIT
;        INT 21H
;        INC DL
;        JMP START
 
        MOV CX,5
        MOV AH,1
         
        INPUT:
          INT 21H
;          MOV BX,CX 
;          MOV CX,0
;          IN:
;            MOV AH,2
;            MOV DL,13
;            INT 21H
;            MOV DL,2AH
;            INT 21H
;          LOOP IN
; 
;          MOV CX,BX

          MOV BL,1
          
;          IN:
;           CMP BL,2
;           JE OUT
;           MOV AH,2
;           MOV DL,13
;           INT 21H
;           MOV DL,2AH
;           INT 21H
;           INC BL
;           JMP IN
;          OUT:
           
          
        LOOP INPUT
        
        
;        MOV AH,2
;        MOV DL,13
;        INT 21H 
;        
;        MOV CX,5
;        IN:
;          MOV AH,2
;          MOV DL,2AH
;          INT 21H
;        LOOP IN 
;        
        
          

;
;        MOV CX,5
;        MOV DL,30H
;        
;        MOV AH,2
;        
;        START:
;          INT 21H
;          INC DL
;        LOOP START
        
        
        
        
        EXIT:
        
        MOV AX, 4C00H
        INT 21H 
        
    MAIN ENDP
    END MAIN                   