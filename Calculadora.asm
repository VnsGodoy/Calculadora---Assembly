TITLE VINICIUS GODOY(22006132) e VICTOR ARONI(22000397)
 
.MODEL small
.DATA
Cima DB '        ___________            $'
Começo DB '===== < CALCULADORA > ===== $'
BV DB ' -> Bem-vindo a calculadora em Assemlby, siga os passos para utiliza-la! <- $'
Baixo DB '   _________________________________________________________________ $'
MSG1 DB ' -> Digite o primeiro numero: $'
MSG2 DB ' -> Digite o segundo numero: $'
MSG3 DB ' -> Digite o sinal que deseja: $'
OP1 DB ?,'$'
OP2 DB ?,'$'

.CODE

PULA_LINHA PROC

MOV DL, 10  ;Pula linha
MOV AH, 02
INT 21H
INT 21H

PULA_LINHA ENDP


SOMA PROC

MOV BL, OP1
SUB BL, 30H
MOV BH, OP2
SUB BH, 30H
ADD BL, BH
SUB BL, 30H
RET


SOMA ENDp




SUBI PROC

SUBI ENDP

MAIN PROC
MOV AX,@DATA  ;Começa o Programa
MOV DS, AX
 
LEA DX, Cima ;Imprime uma mensagem
MOV AH, 09
INT 21H
 
CALL PULA_LINHA
 
LEA DX, Começo
MOV AH, 09
INT 21H
 
CALL PULA_LINHA
 
LEA DX, BV
MOV AH, 09
INT 21H
 
CALL PULA_LINHA
 
LEA DX, Baixo
MOV AH, 09
INT 21H
 
CALL PULA_LINHA
 
LEA DX, MSG1
MOV AH, 09
INT 21H
 
MOV AH, 01     ;Primeira variável
INT 21H
 
MOV OP1, AL  ; Manda para a variável

CALL PULA_LINHA
 
LEA DX, MSG2    
MOV AH, 09      
INT 21H
 
MOV AH, 01   ;Segunda Variável
INT 21H
 
MOV OP2, AL
 
CALL PULA_LINHA
 
LEA DX, MSG3  
MOV AH, 09      
INT 21H
 
MOV AH, 01
INT 21H
 
CMP AL, '+'
JE SOMAOP

SOMAOP:
CALL SOMA
MOV DL, BL
MOV AH, 02
INT 21H
JMP FIM

 
FIM:

MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN
