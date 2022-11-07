TITLE VINÍCIUS DE GODOY (22006132) e VICTOR ARONI ()

.MODEL small
.DATA

;Estéticas e Variáveis:
    Cima DB '        ___________            $'
    Começo DB '===== < CALCULADORA > ===== $'
    BV DB ' -> Bem-vindo a calculadora em Assemlby, siga os passos para utiliza-la! <- $'
    Baixo DB '   _________________________________________________________________ $'
    MSG1 DB ' -> Digite o primeiro numero: $'
    MSG2 DB ' -> Digite o segundo numero: $'
    MSG3 DB ' -> Digite o sinal que deseja: $'
    OP1 DB ?,'$'
    OP2 DB ?,'$'
    Final DB ' -> Resultado: $'
    MensagemFinal DB 'Deseja fazer outra conta (S/N): $'
    NumZero DB 'Digite um numero diferente de zero para divisao, por favor! $'

.CODE

;Limpa tela
LimpaTELA PROC
    MOV DL, 10
    MOV AH, 02
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    RET

LimpaTELA ENDP

;Função apenas para estética
FinalEst PROC

    CALL PULA_LINHA
    LEA DX, Final
    MOV AH, 09
    INT 21H
    RET

FinalEst ENDP

;Função Print Pula-Linha
PULA_LINHA PROC 

    MOV DL, 10
    MOV AH, 02
    INT 21H
    INT 21H
    RET

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

MOV BL, OP1  ;Move o conteúdo de OP1 para o Registrador, pois é nescessário para realizar a operação
SUB BL, 30H  ;Transforma o número em caracter da Tabela ASCII
MOV BH, OP2  ;Move o conteúdo de OP2 para o Registrador, pois é nescessário para realizar a operação
SUB BH, 30H  ;Transforma o número em caracter da Tabela ASCII
SUB BL, BH   ;Faz a operação de Subitração dos dois números
ADD BL, 30H  ;Transforma o número em caracter da Tabela ASCII
RET          ;Retorna

SUBI ENDP

;Função que faz operação de multiplicação da calculadora sem ultilizar o comando MUL
MULT PROC

MOV BL, OP1
SUB BL, 30H  
MOV BH, OP2   
SUB BH, 30H 

Volta:

SHR BL, 1  
JNC PulaMult

ADD CL, BH  

PulaMult:

SHL BH, 1 
CMP BL, 0
JNE Volta
MOV BL, CL
ADD BL, 30H
CALL DECIMAL

RET
MULT ENDp


DIVI PROC

MOV BL, OP1
SUB BL, 30H
MOV BH, OP2
SUB BH, 30H

CMP BH, 48
JE Zero
CMP BH, BL
JE NumerosIguais

SHR BL, 1
JNC PulaDivi

PulaDivi:




NumerosIguais:
XOR BX, BX
MOV BL, 1
CALL DECIMAL

Zero:
CALL LimpaTELA
CALL PULA_LINHA
LEA DX, NumZero
MOV AH, 09
INT 21H
JMP DigiteNovamente


RET

DIVI ENDp

CONTINUA PROC
CALL PULA_LINHA
LEA DX, MensagemFinal
MOV AH, 09
INT 21H

XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

MOV AH, 01
INT 21H

CMP AL, 'S'
JE SIM
CMP AL, 's'
JE SIM
RET

CONTINUA ENDP

;Função que Printa 2 casas decimais no Resultado
DECIMAL PROC

    XOR AX, AX  ;Zera Registrador AX
    SUB BL, 30H 
    MOV AL, BL
    MOV BL, 10 
    DIV BL      ;Sepera o número em 2 partes para Printar 

    MOV BX, AX  
    MOV DL, BL  ;Primeira Parte do Número
    ADD DL, 30H 
    MOV AH, 02
    INT 21H

    MOV DL, BH  ;Segunda Parte do Número
    ADD DL, 30H
    MOV AH, 02
    INT 21H

    RET

    DECIMAL ENDP


MAIN PROC
SIM:

;Começa o Programa
MOV AX,@DATA
MOV DS, AX



;Limpa tela
CALL LimpaTELA
CALL LimpaTELA


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

DigiteNovamente:

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

;Comparando o sinal digitado:
CMP AL, 43  ;Sinal de '+'
JE SOMAOP
CMP AL, 45  ;Sinal de '-'
JE SUBOP
CMP AL, 42  ;Sinal de '*'
JE MULTOP
CMP AL, 47  ;Sinal de '/'
JE DIVIOP

;Função feita para chamar Operação Soma e Printar
SOMAOP:
CALL FinalEst
CALL SOMA
CALL DECIMAL
JMP FIM ;Pula para o final do Programa

;Função feita para chamar Operação Subi e Printar
SUBOP:
CALL FinalEst
CALL SUBI
CALL DECIMAL
JMP FIM ;Pula para o final do Programa

;Função feita para chamar Operação Mult e Printar
MULTOP:
CALL FinalEst
CALL MULT
JMP FIM  ;Pula para o final do Programa

;Função feita para chamar Operação Divi e Printar
DIVIOP:
CALL FinalEst
CALL DIVI
JMP FIM   ;Pula para o final do Programa

;Final do Programa
FIM:
CALL CONTINUA

MOV AH, 4CH  ;Finaliza o Programa
INT 21H
MAIN ENDP
END MAIN
