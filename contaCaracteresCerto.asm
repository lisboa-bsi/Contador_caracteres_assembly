extern printf
extern scanf

global main

section .text
main:
    mov ebp, esp ; Para depuração correta

    ; Exibir o prompt
    push msg1       ; Primeiro argumento: endereço da string de prompt
    call printf
    add esp, 4      ; Ajustar a pilha após a chamada de printf

    ; Ler a entrada do usuário
    lea eax, [texto] ; Carregar o endereço do buffer de entrada em eax
    mov edi, eax     ; EDI é usado como um ponteiro para percorrer o buffer
    push edi         ; Primeiro argumento: endereço do buffer
    push input       ; Segundo argumento: formato de leitura (string)
    call scanf
    add esp, 8       ; Ajustar a pilha após a chamada de scanf

    ; Contar o número de caracteres na entrada (ignorando espaços)
    xor ecx, ecx     ; Zerar o registrador ecx (contador)
 
count_loop:
    mov al, [edi]    ; Carregar o byte atual de texto em al
    cmp al, 0        ; Comparar com o terminador nulo
    je end_count     ; Se for nulo, terminar a contagem
    cmp al, ' '      ; Comparar com espaço
    je skip_space    ; Se for espaço, pular a contagem
    inc ecx          ; Incrementar o contador
skip_space:
    inc edi          ; Ir para o próximo caractere
    jmp count_loop   ; Repetir o loop

end_count:
    ; Exibir o número de caracteres (sem espaços)
    push ecx         ; Primeiro argumento: número de caracteres
    push msg2        ; Segundo argumento: formato de saída para o contador de caracteres
    call printf
    add esp, 8       ; Ajustar a pilha após a chamada de printf

    ; Exibir a entrada lida
    lea eax, [texto] ; Carregar o endereço do buffer de entrada em eax
    push eax         ; Primeiro argumento: endereço do buffer contendo a entrada lida
    call printf
    add esp, 4       ; Ajustar a pilha após a chamada de printf

    ret

section .bss
    texto resb 1024  ; Reserva 1024 bytes para o buffer de entrada, suficiente para entrada maior que uma linha

section .data
    msg1 db 'Digite uma entrada: ', 0        ; String do prompt
    input db '%1023[^\n]', 0                 ; Formato de entrada para string que lê até nova linha, limitado a 1023 caracteres
    msg2 db 'Numero de caracteres (sem espacos): %d', 10, 0 ; Formato de saída para o número de caracteres