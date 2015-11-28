%include 'funciones.asm'

section .text:
	global _start

_start:

	pop ecx											;el primer valor en el stack es el numero de argumentos
	mov edx,0 										;inicializamos el registro de datos

sigArg:
	cmp ecx,0										;checamos si todavia hay argumentos
	jz noMasArgs									;si es cero, ya no hay mas argumentos
	pop eax 										;sacamos del stack el siguiente argumento
	call atoi 										;convertimos el argumento a entero 
	add edx,eax										;sumamos los valores
	dec ecx											;le restamos 1 a ecx
	jmp sigArg 										;saltamos a sigArg para obtener otro argumento

noMasArgs:
	mov eax,edx 									;movemos la suma acumulada en edx
	call iPrintLF									;imprimimos el resultado con LineFeed
	call quit 										;salida