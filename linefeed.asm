section .data                   ;Samaniego Rubiano Cristian Raul
    msj db "la suma es: ", 0xA  ;nuestro mensaje
    lm equ $ - msj              ;longitud del mensaje
    a db '5'                    ;variable a
    b db '3'                    ;variable b
    lf db 0xA                   ;line feed (nueva linea)


section .bss
    sum resb 1                  ;reserva 1 byte para resultado

section .text
    GLOBAL _start
_start:

    mov EDX, lm                     ;movemos la longitud del mensaje
    mov ECX, msj                    ;movemos el mensaje
    mov EBX, 1                      ;descriptor de salida
    mov EAX, 4                      ;sys write
    int 0x80                        ;ejecutar

    mov EAX, [a]                    ;carga la variable 'a'
    sub EAX, '0'                    ;convertimos a entero

    mov EBX, [b]                    ;cargamos la variable 'b'
    sub EBX, '0'                    ;convertimos a entero

    sub EAX,EBX                     ;la suma!
    add EAX, '0'                    ;convertir a caracter
    mov [sum],EAX                   ;guardamos en memoria

    mov ECX, sum                    ;preparamos para imprimir
    mov EDX, 1                      ;cargamos la longitud de 'sum'
    mov EBX, 1                      ;salida estandar
    mov EAX, 4                      ;sys write
    int 0x80                        ;ejecuta

    mov ECX, lf                   ;preparamos para imprimir
    mov EDX, 1                      ;cargamos la longitud de 'line feed'
    mov EBX, 1                      ;salida estandar
    mov EAX, 4                      ;sys write
    int 0x80                        ;ejecuta

    mov EAX, 1                      ;llamada de salida a kernel
    int 0x80                        ;ejecutar
