;autor: Cristian Samaniego
;fecha: 
section .bss
    num resb 1      ;numero a imprimir

section .text
global _start

_start:
    mov ecx, 0      ;inicializar el contador en 0

signum:
    inc ecx         ;incrementa el contador en 1

    mov eax, ecx    ;movemos nuestro entero al acumulador
    add eax, 48     ;'0'
    mov [num], eax  ;guardamos en memoria nuestro numero
    push eax        ;empujamos el valor de eax al stack

    mov edx, 1      ;movemos la longitud del mensaje
    mov ecx, [num]  ;movemos la direccion del mensaje al registro
    mov ebx, 1      ;salida estandar
    mov eax, 4      ;sys write
    int 0x80        ;ejecutar
    pop eax         ;limpiamos el stack
    cmp ecx, 9      ;comparamos nuestro contador con el limite
                    ;ya llegamos al limite?
    jne signum      ;no, volvamos a incrementar el contador

salida:
    mov eax, 1      ;sys exit
    int 0x80        ;ejecuta