;funcion print
;autor: Cristian Samaniego
;fecha: 24/11/15

%include "funciones.asm"
section .data
	msj	db	'Hola mundo con printf', 0xA, 0x0	;nuestro mensaje

section .text
	extern printf
	global main

main:
	push msj		;direccion del mensaje al acumulador (EAX)
	call printf		;imprime
	add ESP, 4		;limpiar stack
	ret