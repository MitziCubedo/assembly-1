;autor: Cristian Samaniego
;fecha: 
section .data
	msj db 'Calcula el tamanio de la cadena', 0xA		;mensaje a escribir en la pantalla

section .text
	global _start

_start:

	mov EBX, msj 										;movemos la direccion del msj a EBX
	mov EAX, EBX 										;copiamos la direccion de msj a EAX

sigcar: 												;siguiente caracter
	cmp byte [EAX], 0 									;comparamos el byte apuntado por EAX contra 0 (cero es el fin de cadena)
	jz finalizar 										;jump if zero: si son iguales, salta a la etiqueta finalizar
	inc EAX 											;incrementamos EAX en 1
	jmp sigcar 											;salto incondicional a sigcar

finalizar:
	sub EAX, EBX 										;resta la direccion apuntada por EBX a la direccion que apunta EAX
														;obtenemos la longitud de la cadena
	mov EDX, EAX 										;pasamos el num de bytes a EDX
	mov ECX, msj 										;pasamos la direccion del  mensaje a ECX
	mov EBX, 1 											;salida estandar(file descriptor)
	mov EAX, 4 											;sys_write (escribir en pantalla)
	int 80h 											;ejecutar

	mov EBX, 0 											;limpiar EBX
	mov EAX, 1 											;sys_exit
	int 80h 											;ejecutar