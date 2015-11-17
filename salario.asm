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
    msg db "Numero mayor: ",0x0

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
    mov EDX, 25000
    jle mayora25
    mov EDX, 10000
    jle mayora10
    jg menora10    
    dec ECX                             ;le restamos 1 a ECX
    jmp sigArg                          ;saltamos a sigArg para obtener otro argumento
    
noMasArgs:
    mov EAX, msg                        ;preparamos para imprimir mensaje
    call sprint                         ;imprimimos
    mov EAX,EDX                         ;movemos nuestro numero mayor para imprimirlo
    call iprintLF                       ;imprimimos el resultado con linefeed
    call quit                           ;salida

sobreEscribir:
    mov EDX, EAX                        ;cuando es mayor mandamos el argumento ya convertido a nuestro registro
    dec ECX                             ;restamos 1 a ecx para pasar al siguiente argumento
    jmp sigArg                          ;saltamos a sigArg para obtener otro argumento