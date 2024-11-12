.text                   # Define as instruções do programa.
main:                   # Rótulo para definir o programa principal.
    li $v0,4            # Carrega 4 em $v0 para indicar uma impressão de string.
    la $a0, greeting    # Carrega o endereço da saudação em $a0.
    syscall             # Imprime a saudação. A impressão é indicada por
                        # $v0 tendo um valor de 4, e a string a ser
                        # impressa está armazenada no endereço em $a0.
    li $v0, 10          # Carrega 10 (parar) em $v0.
    syscall             # O programa termina.
.data                   # Define os dados do programa.
greeting: .asciiz "Hello World" # A string a ser impressa.