;hola mundo otra vez
;autor: Cristian Samaniego
;fecha: 5/oct/2015

%include 'funciones.asm'

section .data
	msj1 db 'nuevo hola mundo!', 0x0		 		;sin line feed
	msj2 db 'con line feed automatico!', 0x0 		;

section .text
	global _start

_start:
	
	mov eax,msj1 									;direccion de msj1 a EAX
	call sprintLF 									;llamamos a sprint con line feed	
	mov eax,msj2									;direccion de msj2 a EAX
	call sprintLF 									;llamamos a la misma funcion
	call quit										;llamamos a la salida