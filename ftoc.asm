;ftoc.asm farenheit to celsius
;Cristian Samaniego
;
%include 'funciones.asm' 

section .data
	msg1 db	" f son:",0x0 				;definimos mensaje1
	msg2 db " c",0x0   					;definimos mensaje
section .text
	global _start
	
_start:
	
	pop ECX 							;obtenemos el numero de argumentos del stack
	pop EAX 							;sacamos del nombre del programa del stack (el argumento 0)
	dec ECX 							;le restamos 1 a ECX
	
sigArg:
	cmp ECX, 0							;checamos si todavia hay argumentos
	jz noMasArgs 						;si cero, ya no hay mas argumentos
	pop EAX								;sacamos del stack el siguiente argumento
	call atoi							;convertimos el argumento a entero
	call iprint							;imprimos grados farenheit
	push EAX    						;salvamos el numero en forma decimal
	mov EAX, msg1 						;preparamos para imprimir mensaje
	call sprint 						;imprimimos
	pop EAX     						;regresamos el numero a convertir
	call convierteftoc 					;convertimos de f a c
	call iprint 						;imprimimos el numero
	mov EAX, msg2 						;preparamos para imprimir el segundo mensaje
	call sprintLF 						;imprimimos con linefeed
	
	
	dec ECX								;le restamos 1 a ECX
	jmp sigArg  						;saltamos a sigArg para obtener otro argumento
	
	
	
noMasArgs:
	mov EAX, EDX 						; movemos la suma acumulada en EDX
	;call iprintLF 						;imprimimos el resultado con linefeed
	call quit     						;salida