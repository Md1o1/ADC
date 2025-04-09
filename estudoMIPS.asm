.data
array:      .word 10, 13, 15, 42, 20   # Array de exemplo
array_size: .word 5                    # Tamanho do array
sum:        .word 0                    # Soma inicializada em 0
product:    .word 1                    # Produto inicializado em 1
result:     .word 0                    # Resultado da verificação
comparison: .word 100                  # Valor de comparação fixado em 100
newline:    .asciiz "\n"               # Nova linha

.text
.globl main
main:
    # Inicializações
    la $t0, array           # Carrega o endereço do array em $t0
    lw $t1, array_size      # Carrega o tamanho do array em $t1
    la $t2, sum             # Carrega o endereço da soma em $t2
    la $t3, product         # Carrega o endereço do produto em $t3

    li $t6, 0               # Inicializa acumulador de soma em $t6
    li $t7, 1               # Inicializa acumulador de produto em $t7
    li $t4, 0               # Inicializa índice em $t4

soma_prod_loop:
    beq $t4, $t1, end_loop  # Se índice >= tamanho, sair do loop
    lw $t5, 0($t0)          # Carrega o próximo elemento do array
    add $t6, $t6, $t5       # Soma ao acumulador
    mul $t7, $t7, $t5       # Multiplica ao acumulador
    addi $t4, $t4, 1        # Incrementa o índice
    addi $t0, $t0, 4        # Avança para o próximo elemento
    j soma_prod_loop

end_loop:
    # Armazena soma e produto na memória
    sw $t6, 0($t2)          # Salva a soma na memória
    sw $t7, 0($t3)          # Salva o produto na memória

    # Verificação condicional
    lw $t8, comparison      # Carrega o valor limite (100 fixo)
    blt $t6, $t8, less_than # Se soma < limite, salve 0
    li $t9, 1               # Caso contrário, salve 1
    j save_result

less_than:
    li $t9, 0               # Salva 0 se soma < limite

save_result:
    sw $t9, result          # Salva o resultado na memória

    # Exibição dos resultados
    # Exibe soma
    li $v0, 1               # Serviço para imprimir inteiro
    lw $a0, 0($t2)          # Carrega a soma
    syscall
    # Exibe nova linha
    li $v0, 4               # Serviço para imprimir string
    la $a0, newline         # Carrega o caractere de nova linha
    syscall

    # Exibe produto
    li $v0, 1               # Serviço para imprimir inteiro
    lw $a0, 0($t3)          # Carrega o produto
    syscall
    # Exibe nova linha
    li $v0, 4               # Serviço para imprimir string
    la $a0, newline         # Carrega o caractere de nova linha
    syscall

    # Exibe resultado da verificação
    li $v0, 1               # Serviço para imprimir inteiro
    lw $a0, result          # Carrega o resultado
    syscall
    # Exibe nova linha
    li $v0, 4               # Serviço para imprimir string
    la $a0, newline         # Carrega o caractere de nova linha
    syscall

    # Finaliza o programa
    li $v0, 10              # Serviço para encerrar o programa
    syscall
