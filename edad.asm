;Edad.asm
; Cristian Samaniego

%include 'funciones.asm'

section .data
Nombre db "como te llamas? ", 0x0
Hola db "Hola ", 0x0
Edad db "Cual es tu edad? ", 0x0
Joven db "Eres joven", 0x0
Adulto db "Eres Adulto", 0x0
Tercera db "Eres una persona de la tercera edad", 0x0

section .bss
Buffer resb 10
Buffer_len equ $-Buffer
BufferNum resb 4
BufferNum_len equ $-BufferNum

section .text
global _start:

_start:
    mov eax, Nombre                     ;preparamos para imprimir la pregunta
    call sprint                         ;mandamos a imprimir

    mov ecx, Buffer                     ;direccion de buffer a ecx
    mov edx, Buffer_len                 ;longitud de buffer a edx
    call LeerTexto                      ;leemos lo que escriba el usuario

    mov eax, Hola                       ;preparamos para imprimir "Hola "
    call sprint                         ;imprimimos
    mov eax, Buffer                     ;preparamos para imprimir lo que esta en buffer
    call sprintLF                       ;imprimimos

    mov eax, Edad                       ;preparamos para imprimir "Cual es tu edad?"
    call sprint                         ;mandamos a imprimir

    mov ecx, BufferNum                     ;direccion de buffer a ecx
    mov edx, BufferNum_len                 ;longitud de buffer a edx
    call LeerTexto                      ;leemos lo que escriba el usuario
    mov eax,ecx                         ;movemos lo que esta en ecx (la edad) a eax
    call atoi                           ;convertimos a entero
    cmp eax, 18                         ;comparamos con 18 anios
    jl joven                            ;saltamos si es mejor a 18
    jge segundaComparacion              ;volvemos a comparar

joven:
    mov eax, Joven                      ;movemos el mensaje si es joven
    call sprintLF                       ;imprimimos
    call quit                           ;salimos

segundaComparacion:                     ;volvemos a comparar
    cmp eax, 60                         ;comparamos con 60 anios   
    jl adulto                           ;saltamos a adulto si es menor
    jge terceraEdad                     ;si es mayor o igual saltamos a terceraEdad

adulto:
    mov eax, Adulto                     ;movemos el mensaje si es adulto
    call sprintLF                       ;imprimimos
    call quit                           ;salimos

terceraEdad:
    mov eax, Tercera                    ;movemos el mensaje si es de la tercera edad
    call sprintLF                       ;imprimimos
    call quit                           ;salimos    