;par.asm detecta si un numero es par o impar
; Cristian samaniego

%include 'funciones.asm'

section .data
	espar db " es par", 0x0		;declara mensaje par
	esimpar db " es impar", 0x0  ;declara mensaje es impar

section .text		
	global _start
_start:
	
		
	pop ECX ;obtenemos el numero de argumentos del stack
	pop EAX ;sacamos del nombre del programa del stack (el argumento 0)
	dec ECX ;le restamos 1 a ECX
	
sigArg:
	cmp ECX, 0	;checamos si todavia hay argumentos
	jz noMasArgs ;si cero, ya no hay mas argumentos
	pop EAX		;sacamos del stack el siguiente argumento
	call atoi	;convertimos el argumento a entero
	call iprint;imprimimos el numero
	AND EAX, 1	;es par o impar
	jz par		;salta a la etiqueta par si es igual a cero
	mov EAX, esimpar	;movemos el mensaje/// nos preparamos para imprimir
    call sprintLF	;llamamos a imprimir con LineFeed
	
	dec ECX		;le restamos 1 a ECX
	jmp sigArg  ;saltamos a sigArg para obtener otro argumento

par:
	mov EAX, espar 	;preparamos para imprimir
	call sprintLF	;imprimimos con LineFeed
	dec ECX		;le restamos 1 a ECX
	jmp sigArg	;saltamos a sigArg para obtener otro argumento
	
noMasArgs:
	mov EAX, EDX ; movemos la suma acumulada en EDX
	;call iprintLF ;imprimimos el resultado con linefeed
	call quit     ;salida