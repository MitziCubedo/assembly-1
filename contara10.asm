;funcion sprint
;autor: Cristian Samaniego
;fecha: 13/oct/2015
%include "funciones.asm"

section .text
	global _start

_start:

	mov ecx,0 						;contador a cero

sigNum:
	inc ecx 						;incrementamos el contadfor en 1
	mov eax,ecx						;enviamos el numero a imprimir a EAX
	call iPrintLF					;mandamos a imprimir
	cmp ecx,10						;comparamos para saber si ya llego a 10
	jne sigNum 						;si la comparamos y no es igual: siguiente numero

	call quit 						;salimos