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
SOMA DB ?,'$'
SUBTRACAO DB ?,'$'
.CODE
 
MAIN PROC
MOV AX,@DATA
MOV DS, AX
 
LEA DX, Cima ;Imprime uma mensagem
MOV AH, 09
INT 21H
 
MOV DL, 10  ;Pula linha
MOV AH, 02
INT 21H
 
LEA DX, Começo
MOV AH, 09
INT 21H
 
MOV DL, 10
MOV AH, 02
INT 21H
 
MOV DL, 10
MOV AH, 02
INT 21H
 
LEA DX, BV
MOV AH, 09
INT 21H
 
MOV DL, 10
MOV AH, 02
INT 21H
 
LEA DX, Baixo
MOV AH, 09
INT 21H
 
MOV DL, 10
MOV AH, 02
INT 21H
 
MOV DL, 10
MOV AH, 02
INT 21H
 
 
LEA DX, MSG1
MOV AH, 09
INT 21H
 
MOV AH, 01     ;Primeira variável
INT 21H
 
SUB AL, 30H  ; Transformação Tabela Asc
 
MOV DL, 10
MOV AH, 02
 
INT 21H
 
LEA DX, MSG2    
MOV AH, 09      
INT 21H
 
MOV AH, 01   ;Segunda Variável
INT 21H
 
MOV AL, 30H ; Transformação Tabela Asc
MOV BH, AL
 
MOV DL, 10
MOV AH, 02
 
INT 21H
 
LEA DX, MSG3  
MOV AH, 09      
INT 21H
 
MOV AH, 01
INT 21H
 
CMP AL, '+'
JA Operador
 
Operador:
ADD BL, 0
ADD BH, 0
ADD BL, BH
MOV DL, BL
ADD DL, 48
INT 21H
 
MOV AL, DL
MOV AH, 02
 
 
 
MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN
 
 
 
 
 
 
 
 

