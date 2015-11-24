; salario.asm Calcula el impuesto al sueldo
; Cristian Samaniego
; 17/11/2015
;-------------------------------------------
; sueldo > 50000 impuesto = 35%
; sueldo > 25000 y < 50000 impuesto = 30%
; sueldo > 10000 y < 24999 impuesto = 20%
; sueldo < 10000  impuesto = 0%
; debe imprimir:
; salario: 55000
; impuesto: 19250
; sueldo neto: 35750
;-------------------------------------------

%include 'funciones.asm' 

section .data
	msgsalario db "Salario: ", 0x0
	msgimpuesto db "Impuesto: ", 0x0
    msgsueldo db "Sueldo neto: ", 0x0
    rayitas db "----------------------", 0x0

section .text
    global _start
    
_start:
    pop ECX                             ;obtenemos el numero de argumentos del stack
    pop EAX                             ;sacamos el nombre del programa del stack (el argumento 0)
    dec ECX                             ;le restamos 1 a ECX
    ;mov EDX, 0                          


sigArg:
    cmp ECX, 0                          ;checamos si todavia hay argumentos
    jz noMasArgs                        ;si cero, ya no hay mas argumentos
    pop EAX                             ;sacamos del stack el siguiente argumento
    call atoi                           ;convertimos el argumento a entero   
    mov EDX, 50000						;movemos 50000 para comparar con el salario
    cmp EDX,EAX                         ;comparamos lo que esta en EAX con nuestro numero mayor
    jle mayora50	                    ;si es mayor, sobreescribimos el registro
    mov EDX, 25000                      ;movemos 25000 para comparar
    cmp EDX, EAX                        ;comparamos 
    jle mayora25                        ;si es mayor, saltamos a la etiqueta
    mov EDX, 10000                      ;movemos 10000 para comparar
    cmp EDX, EAX                        ;comparamos
    jle mayora10                        ;si es mayor o igual, saltamos a la etiqueta
    jg menora10                         ;si es menor, saltamos a la otra etiqueta
    dec ECX                             ;le restamos 1 a ECX
    jmp sigArg                          ;saltamos a sigArg para obtener otro argumento
    
noMasArgs:
    ;mov EAX, msg                        ;preparamos para imprimir mensaje
    ;call sprint                         ;imprimimos
    ;mov EAX,EDX                         ;movemos nuestro numero mayor para imprimirlo
    ;call iprintLF                       ;imprimimos el resultado con linefeed
    call quit                           ;salida

mayora50:
	push eax                           ;salvamos el sueldo al stack
	mov eax,msgsalario                 ;movemos el mensaje a imprimir
	call sprint                        ;imprimimos la cadena
	pop eax                            ;sacamos el sueldo del stack a eax
	call iprintLF                      ;imprimimos el entero

    push ecx                           ;salvamos ebx en el stack
	mov ecx,eax                        ;movemos el sueldo a ebx
    push eax                           ;guardamos eax en el stack               
	mov eax, msgimpuesto               ;movemos el mensaje a imprimir
	call sprint                        ;imprime
	pop eax                            ;sacamos del stack a eax el sueldo
	mov edx, 35                        ;movemos el 30 para sacar el porcentaje
	mul edx                            ;multiplicamos
	mov ebx, 100                       ;movemos el 100 para dividir
	div ebx                            ;dividimos
    call iprintLF                      ;imprimimos el entero con line feed
	push eax                           ;salvamos el valor de eax
    mov eax, msgsueldo                 ;movemos el mensaje a eax
    call sprint                        ;imprimimos 
    pop eax                            ;sacamos el valor del stack y lo ponemos en eax
    sub ecx,eax                        ;restamos el impuesto al sueldo para calcular el sueldo neto
    mov eax,ecx                        ;movemos a eax para imprimir
    call iprintLF                      ;imprimimos con line feed
    mov eax, rayitas                   ;movemos las rayitas a eax
    call sprintLF                      ;imprimimos con line feed

    pop ecx                            ;devolvemos ecx del stack (el numero del argumento)
    dec ecx                            ;restamos para pasar al siguiente argumento
	jmp sigArg                         ;volvemos a iterar

mayora25:
	push eax                           ;salvamos el sueldo al stack
    mov eax,msgsalario                 ;movemos el mensaje a imprimir
    call sprint                        ;imprimimos la cadena
    pop eax                            ;sacamos el sueldo del stack a eax
    call iprintLF                      ;imprimimos el entero

    push ecx                           ;salvamos ebx en el stack
    mov ecx,eax                        ;movemos el sueldo a ebx
    push eax                           ;guardamos eax en el stack               
    mov eax, msgimpuesto               ;movemos el mensaje a imprimir
    call sprint                        ;imprime
    pop eax                            ;sacamos del stack a eax el sueldo
    mov edx, 30                        ;movemos el 30 para sacar el porcentaje
    mul edx                            ;multiplicamos
    mov ebx, 100                       ;movemos el 100 para dividir
    div ebx                            ;dividimos
    call iprintLF                      ;imprimimos el entero con line feed
    push eax                           ;salvamos el valor de eax
    mov eax, msgsueldo                 ;movemos el mensaje a eax
    call sprint                        ;imprimimos 
    pop eax                            ;sacamos el valor del stack y lo ponemos en eax
    sub ecx,eax                        ;restamos el impuesto al sueldo para calcular el sueldo neto
    mov eax,ecx                        ;movemos a eax para imprimir
    call iprintLF                      ;imprimimos con line feed
    mov eax, rayitas                   ;movemos las rayitas a eax
    call sprintLF                      ;imprimimos con line feed

    pop ecx                            ;devolvemos ecx del stack (el numero del argumento)
    dec ecx                            ;restamos para pasar al siguiente argumento
    jmp sigArg                         ;volvemos a iterar

mayora10:
	push eax                           ;salvamos el sueldo al stack
    mov eax,msgsalario                 ;movemos el mensaje a imprimir
    call sprint                        ;imprimimos la cadena
    pop eax                            ;sacamos el sueldo del stack a eax
    call iprintLF                      ;imprimimos el entero

    push ecx                           ;salvamos ebx en el stack
    mov ecx,eax                        ;movemos el sueldo a ebx
    push eax                           ;guardamos eax en el stack               
    mov eax, msgimpuesto               ;movemos el mensaje a imprimir
    call sprint                        ;imprime
    pop eax                            ;sacamos del stack a eax el sueldo
    mov edx, 20                        ;movemos el 30 para sacar el porcentaje
    mul edx                            ;multiplicamos
    mov ebx, 100                       ;movemos el 100 para dividir
    div ebx                            ;dividimos
    call iprintLF                      ;imprimimos el entero con line feed
    push eax                           ;salvamos el valor de eax
    mov eax, msgsueldo                 ;movemos el mensaje a eax
    call sprint                        ;imprimimos 
    pop eax                            ;sacamos el valor del stack y lo ponemos en eax
    sub ecx,eax                        ;restamos el impuesto al sueldo para calcular el sueldo neto
    mov eax,ecx                        ;movemos a eax para imprimir
    call iprintLF                      ;imprimimos con line feed
    mov eax, rayitas                   ;movemos las rayitas a eax
    call sprintLF                      ;imprimimos con line feed

    pop ecx                            ;devolvemos ecx del stack (el numero del argumento)
    dec ecx                            ;restamos para pasar al siguiente argumento
    jmp sigArg                         ;volvemos a iterar

menora10:
	push eax                           ;salvamos el sueldo al stack
    mov eax,msgsalario                 ;movemos el mensaje a imprimir
    call sprint                        ;imprimimos la cadena
    pop eax                            ;sacamos el sueldo del stack a eax
    call iprintLF                      ;imprimimos el entero

    push ecx                           ;salvamos ebx en el stack
    mov ecx,eax                        ;movemos el sueldo a ebx
    push eax                           ;guardamos eax en el stack               
    mov eax, msgimpuesto               ;movemos el mensaje a imprimir
    call sprint                        ;imprime
    pop eax                            ;sacamos del stack a eax el sueldo
    mov edx, 0                        ;movemos el 30 para sacar el porcentaje
    mul edx                            ;multiplicamos
    mov ebx, 100                       ;movemos el 100 para dividir
    div ebx                            ;dividimos
    call iprintLF                      ;imprimimos el entero con line feed
    push eax                           ;salvamos el valor de eax
    mov eax, msgsueldo                 ;movemos el mensaje a eax
    call sprint                        ;imprimimos 
    pop eax                            ;sacamos el valor del stack y lo ponemos en eax
    sub ecx,eax                        ;restamos el impuesto al sueldo para calcular el sueldo neto
    mov eax,ecx                        ;movemos a eax para imprimir
    call iprintLF                      ;imprimimos con line feed
    mov eax, rayitas                   ;movemos las rayitas a eax
    call sprintLF                      ;imprimimos con line feed

    pop ecx                            ;devolvemos ecx del stack (el numero del argumento)
    dec ecx                            ;restamos para pasar al siguiente argumento
    jmp sigArg                         ;volvemos a iterar