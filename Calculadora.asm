TITLE Calculadora Assembly 
.MODEL small
.DATA

;Estéticas e Variáveis:
Cima DB '        ___________            $'
Começo DB '===== < CALCULADORA > ===== $'
BV DB ' -> Bem-vindo a calculadora em Assemlby, siga os passos para utiliza-la! <- $'
Baixo DB '   _________________________________________________________________ $'
MSG1 DB ' -> Digite o primeiro numero: $'
MSG2 DB ' -> Digite o segundo numero: $'
MSG3 DB ' -> Digite a operacao que deseja: $'
OP1 DB ?,'$'
OP2 DB ?,'$'
Final DB '-> Resultado: $'

.CODE


MAIN PROC

CALL INICIO

CALL COMPARE

CALL SOMAESUBI

MAIN ENDP


;Função apenas para estética
FinalEst PROC

MOV DL, 10
MOV AH, 02
INT 21H
INT 21H

LEA DX, Final
MOV AH, 09
INT 21H

FinalEst ENDP

;Função Print Pula-Linha
PULA_LINHA PROC 

MOV DL, 10
MOV AH, 02
INT 21H
INT 21H

PULA_LINHA ENDP

;Função que faz a operação de soma da calculadora
SOMA PROC

MOV BL, OP1  ;Move o conteúdo de OP1 para o Registrador, pois é nescessário para realizar a operação
SUB BL, 30H  ;Transforma o número em caracter da Tabela ASCII
MOV BH, OP2  ;Move o conteúdo de OP2 para o Registrador, pois é nescessário para realizar a operação
SUB BH, 30H  ;Transforma o número em caracter da Tabela ASCII
ADD BL, BH   ;Faz a operação de Soma dos dois números
ADD BL, 30H  ;Transforma o número em caracter da Tabela ASCII
RET          ;Retorna

SOMA ENDp

;Função que faz a operação de subtração da calculadora
SUBI PROC

MOV BL, OP1
SUB BL, 30H
MOV BH, OP2
SUB BH, 30H
SUB BL, BH   ;Faz a operação de Subtração dos dois números
ADD BL, 30H
RET

SUBI ENDP

;Função de mensagens e armazenamento dos valores
INICIO PROC

;Começa o Programa
MOV AX,@DATA
MOV DS, AX

;Imprime uma mensagem
LEA DX, Cima 
MOV AH, 09
INT 21H
 
CALL PULA_LINHA ;Print Pula

;Imprime uma mensagem
LEA DX, Começo
MOV AH, 09
INT 21H
 
CALL PULA_LINHA ;Print Pula

;Imprime uma mensagem
LEA DX, BV
MOV AH, 09
INT 21H
 
CALL PULA_LINHA ;Print Pula

;Imprime uma mensagem
LEA DX, Baixo
MOV AH, 09
INT 21H
 
CALL PULA_LINHA ;Print Pula

;Pede o primeiro número
LEA DX, MSG1
MOV AH, 09
INT 21H

;Primeira variável
MOV AH, 01 
INT 21H

;Manda para a variável
MOV OP1, AL 

CALL PULA_LINHA ;Print Pula

;Pede o segundo número
LEA DX, MSG2    
MOV AH, 09      
INT 21H

;Segunda Variável
MOV AH, 01   
INT 21H

;Manda para a segunda variavel
MOV OP2, AL
 
CALL PULA_LINHA ;Print Pula

;Pede o sinal da operação
LEA DX, MSG3  
MOV AH, 09      
INT 21H
 
MOV AH, 01
INT 21H

INICIO ENDP

;Função de compare para designar soma ou sub
COMPARE PROC

;Comparando o sinal digitado:
CMP AL, 43  ;Sinal de '+'
JE SOMAOP
CMP AL, 45  ;Sinal de '-'
JE SUBOP


COMPARE ENDP

;Função que contém os procedimentos de soma, sub e encerra o programa
SOMAESUBI PROC

;Função feita para chamar Operação Soma e Printar
SOMAOP:
CALL FinalEst
CALL SOMA
MOV DL, BL
MOV AH, 02  ;Printa o Resultado
INT 21H
JMP FIM ;Pula para o final do Programa

;Função feita para chamar Operação Subi e Printar
SUBOP:
CALL FinalEst
CALL SUBI
MOV DL, BL
MOV AH, 02  ;Printa o Resultado
INT 21H
JMP FIM ;Pula para o final do Programa

;Final do Programa
FIM:

MOV AH, 4CH  ;Finaliza o Programa
INT 21H

SOMAESUBI ENDP

END MAIN
