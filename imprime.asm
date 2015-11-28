;funcion imprime
;autor: Cristian Samaniego
;fecha: 25/11/15

%include "funciones.asm"
section .data
	msj	db	'La hora es %d con %d', 0xA, 0x0	;nuestro mensaje

section .text
	extern printf
	global main

main:
	mov eax,5 		;cargamos 5 en eax
	mov ebx,20 		;cargamos 20 en eax
	push ebx		;
	push eax		;

	push msj		;direccion del mensaje al acumulador (EAX)
	call printf		;imprime
	add esp,12		;limpiar stack
	ret 			;salida