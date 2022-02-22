; PROGRAM :: REVERSE A GIVEN STRING AND CHECK WHETHER IT IS A PALINDROME
; OR NOT

.MODEL SMALL

DISPLAY MACRO MSG
        LEA DX, MSG ;mov dx,offset msg1
        MOV AH, 09H
        INT 21H
ENDM

.DATA
MSG1 DB 0DH, 0AH, "ENTER STRING   :: $"
MSG2 DB 0DH, 0AH, "REVERSE STRING :: $"
MSG3 DB 0DH, 0AH, "INPUT STRING IS PALINDROME.$"
MSG4 DB 0DH, 0AH, "INPUT STRING IS NOT A PALINDROME STRING.$"

STRING DB 80H DUP(?)
RSTRING DB 80H DUP(?)

.CODE
START : MOV AX, @DATA
        MOV DS, AX

        DISPLAY MSG1
        ; TAKE THE STRING FROM KEYBOARD CHARACTER BY CHARACTER 

        MOV SI, OFFSET STRING
        XOR CL, CL			;clearing CL to store values
AGAIN:  MOV AH, 01H
        INT 21H

        CMP AL, 0DH			;comparing to see if input is equal to 'Enter' key
        JE NEXT

        MOV [SI], AL
        INC SI
        INC CL				;incrementing counter for no. of elements
        JMP AGAIN
NEXT :  MOV [SI], BYTE PTR '$'
        ; STRING INPUT OVER....

        DEC SI
        MOV CH, CL

        ; REVERSE THE STRING AND STORE IN RSTRING
        MOV DI, OFFSET RSTRING
BACK:   MOV AL, [SI]
        MOV [DI], AL
        DEC SI
        INC DI
        DEC CH				;CH starts with value as no. of elements in SI, keeps decrementing
        JNZ BACK
        MOV [DI], BYTE PTR '$'
        DISPLAY MSG2
        DISPLAY RSTRING

        MOV SI,OFFSET STRING
        MOV DI, OFFSET RSTRING
AG:     MOV AL, [SI]
        CMP AL, [DI]
        JNE FAIL
        INC SI
        INC DI
        DEC CX
        JZ SUCCESS
        JMP AG
FAIL:   DISPLAY MSG4
        JMP FINAL
SUCCESS:DISPLAY MSG3       
FINAL:  MOV AH, 4CH
        INT 21H
END



