TITLE Calculadora em Assembly

.MODEL small
.DATA

;Estéticas e Variáveis:
    Cima DB '                                ______________           $'
    Começo DB '=============================== < CALCULADORA > =============================== $'
    BV DB ' -> Bem-vindo a calculadora em Assemlby, siga os passos para utiliza-la! <- $'
    Baixo DB '_______________________________________________________________________________ $'
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


;Função que faz a operação de subtração positiva da calculadora
SUBI PROC
    SubNormal:

    MOV BL, OP1  ;Move o conteúdo de OP1 para o Registrador, pois é nescessário para realizar a operação
    SUB BL, 30H  ;Transforma o número em caracter da Tabela ASCII
    MOV BH, OP2  ;Move o conteúdo de OP2 para o Registrador, pois é nescessário para realizar a operação
    SUB BH, 30H  ;Transforma o número em caracter da Tabela ASCII
    SUB BL, BH   ;Faz a operação de Subitração dos dois números
    ADD BL, 30H  ;Transforma o número em caracter da Tabela ASCII
    MOV DL, BL
    MOV AH, 02
    INT 21H

    JMP FIM    ;Jump para o final do programa

    RET          ;Retorna

SUBI ENDP


;Função que faz operação de multiplicação da calculadora sem ultilizar o comando MUL
MULT PROC

    ;Manda das variaveis para os registradores
    MOV BL, OP1
    SUB BL, 30H  
    MOV BH, OP2   
    SUB BH, 30H 

    ;Confere se possui Carry, caso positivo ADD BH EM CL e depois manda de CL para BL para printar decimal
    Volta:

        SHR BL, 1  
        JNC PulaMult
        ADD CL, BH  

    ;Multiplicação com Numero impar/sem carry
    PulaMult:

        SHL BH, 1
        CMP BL, 0
        JNE Volta    ;Volta caso o Bl ainda não seja 0, até que seja verdade
        MOV BL, CL
        ADD BL, 30H
        CALL DECIMAL   ;Chama as 2 casas decimais para o Resultado
        RET

MULT ENDp


DIVI PROC

    ;Manda as variáveis para os registradores
    MOV BL, OP1
    SUB BL, 30H
    MOV BH, OP2
    CMP BH, 48      ;Compara para ver se é Zero, pois não existe divisão com 0
    JE Zero         ;Caso 0 pula para o procedimento 'Zero'
    CMP BH, 49      ;Compara para ver se é Um, pois todo numero divido por 1 dá ele mesmo
    JE Um           ;Caso 1 pula para o proceidmento 'Um'
    SUB BH, 30H

    CMP BH, BL      ;Compara para ver se os números não são iguais, pois todo numero dividido por ele mesmo da 1
    JE NumerosIguais  ;Caso iguais pula para o procedimento 'NumerosIguais'
    JMP Pulo_Divi_Principal  ;Pula para a operação de divisão geral

    ;Função de Numeros Iguais
    NumerosIguais:
        
        XOR BX, BX
        MOV BL, 1
        ADD BL, 30H 
        CALL DECIMAL
        JMP Retorna

    ;Função para divisão por 1
    Um:
        ADD BL, 30H 
        CALL DECIMAL
        JMP Retorna

    ;Função para divisão por 0
    Zero:

        CALL LimpaTELA
        CALL PULA_LINHA
        LEA DX, NumZero
        MOV AH, 09
        INT 21H
        JMP DigiteNovamente

    ;Função para caso 8/4
    PulaDiv2:

    SHR BL, 1
    SUB BH, 1
    CMP BL, 0   ;Caso seja Par ativa o carry, caso impar não ativa o Carry
    JNC PulaDiviP

    ADD AL, BH   ;Finalização de Divisão Par
    JMP Retorna

    ;Casos como 8/4 onde os números precisam ser jogados para a direita mais de 1 vez
    PulaDiviP:
    CMP BH, 1
    JE PulaDiviP2
    JNE PulaDiv2

    PulaDiviP2:
    SHR BH, 1
    SHR BL, 1


    ADD BL, 30H
    CALL DECIMAL
    JMP Retorna

    ;Função Principal da Divisão
    Pulo_Divi_Principal:
    
    XOR AX, AX
    SHR BH, 1   ;Joga para direita os 2 valores e compara para saber se é par ou impar o numero dividido
    JNC PulaDiv2

    ;Função para Numero impar vai jogar para direita até zerar o BL
    PulaDivIm:

    SHR BL, 1
    JMP PuloDiv3

    PuloDiv4:
    SUB BL, BH
    MOV AL, BL
    SUB BH, 1
    ADD BL, 30H
    CALL DECIMAL

    PuloDiv3:
    CMP BH, 1
    JE PuloDiv4
    
    ;Jump de finalizar a Divisão
    Retorna:

        RET

DIVI ENDp

;Função que Pergunta/Repete o program pela resposta do Usuário
CONTINUA PROC
    
    CALL PULA_LINHA
    LEA DX, MensagemFinal   ;Printa a Pergunta
    MOV AH, 09
    INT 21H

    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

    MOV AH, 01
    INT 21H

    CMP AL, 'S'     ;Compara se a resposta foi Sim e reinicia caso positivo
    JE SIM
    CMP AL, 's'     ;Compara se a resposta foi Sim e reinicia caso positivo
    JE SIM
    CMP AL, 'N'     ;Compara se a resposta foi Não e finaliza o programa caso positivo
    CALL FimN
    CMP AL, 'n'     ;Compara se a resposta foi Não e finaliza o programa caso positivo
    CALL FimN

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

FimN PROC

    MOV AH, 4CH  ;Finaliza o Programa
    INT 21H

FimN ENDP


MAIN PROC

;Jump de Continuar do Programa
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

    MOV OP1, AL
    JMP PulaSub

SubNormal1:
    JMP SubNormal

    PulaSub:

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
    MOV BL, OP1  ;Move o conteúdo de OP1 para o Registrador, pois é nescessário para realizar a operação
    SUB BL, 30H  ;Transforma o número em caracter da Tabela ASCII
    MOV BH, OP2  ;Move o conteúdo de OP2 para o Registrador, pois é nescessário para realizar a operação
    SUB BH, 30H  ;Transforma o número em caracter da Tabela ASCII
    CMP BL, BH
    JG SubNormal1   ;Jump para aumentar a distancia
    SUB BH, BL   ;Faz a operação de Subitração dos dois números
    MOV CL, BH
    NEG BH       ;Utilizado para transformar em numero negativo
    CMP BH, 0    ;Comparador para saber se é numero negativo
    JGE ResultadoSUB   ;Caso seja Negativo pula para a função ResultadoSub
    ResultadoSUB:
    MOV DL, 45   ;Coloca o sinal '-' na frente para imprimir
    MOV AH, 02
    INT 21H
    MOV DL, CL   ;Move o resultado de CL para DL para printar
    ADD DL, 30H
    MOV AH, 02
    INT 21H
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
    
    CALL CONTINUA  ;Pergunta se quer repetir o programa

MOV AH, 4CH  ;Finaliza o Programa
INT 21H

MAIN ENDP
END MAIN
