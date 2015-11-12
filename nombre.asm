;nombre.asm
; Cristian Samaniego
%include 'funciones.asm'

section .data
Nombre db "como te llamas? ", 0x0
Hola db "Hola ", 0x0

section .bss
Buffer resb 10
Buffer_len equ $-Buffer

section .text
global _start:

_start:
    mov eax, Nombre                     ;preparamos para imprimir la pregunta
    call sprint                         ;mandamos a imprimir

    mov ecx, Buffer                     ;direccion de buffer a ecx
    mov edx, Buffer_len                 ;longitud de buffer a edx
    call LeerTexto

    mov eax, Hola                       ;preparamos para imprimir "Hola "
    call sprint                         ;imprimimos
    mov eax, Buffer                     ;preparamos para imprimir lo que esta en buffer
    call sprintLF                       ;imprimimos
    call quit                           ;salimos
