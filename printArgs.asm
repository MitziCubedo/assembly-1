;imprime_argumentos.asm
;imprime los argumentos de la linea de comandos
;autor: Cristian Samaniego
;Fecha 6/oct/2015
%include 'funciones.asm' 				;aqui esta la funcion de imprimir

section .text
	global _start

_start:
	
	pop ecx 							;obtenemos el numero de argumentos del stack

SigArg:
	cmp ecx,0h 							;es igual a cero el numero de argumentos?
	jz NoMasArgs 						;si es cero, salta a No mas argumentos
	pop eax								;guardamos el siguiente valor del stack en EAX
	call sprintLF						;llamamos a sprint con linefeed
	dec ecx 							;le restamos 1 a ECX:[sub ECX,1] hace lo mismo
	jmp SigArg 							;salto a la etiqueta

NoMasArgs:
	call quit


