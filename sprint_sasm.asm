;funcion sprint
;autor: Cristian Samaniego
;fecha: 30/sept/2015
section .data
	msj db 'Hola mundo otra vez',0xA					;nuestro mensaje

section .text
	global main

main:
	mov eax, msj 										;direccion del mensaje al acumulador (EAX)
	call sprint 										;imprime
	call quit 											;salida
	
	;call strlen 										;llamamos a la funcion strlen (longitud de mensaje)

	;mov edx,eax											;tamanio de la cadena a edx
	;mov ecx,msj 										;direccion del mensaje a ecx
	;mov ebx,1											;descriptor de archivo (salida estandar)
	;mov eax,4 											;sys_write
	;int 80h												;ejecuta

	;mov ebx,0 											;iniciamos secuencia de salida
	;mov eax,1 											;sys_exit
	;int 80h

strlen:													;funcion strlen
	push ebx											;salvamos el valor de ebx en la pila (stack)
	mov ebx, eax 										;copiamos la direccion del mensaje a ebx

sigcar: 
	cmp byte[eax],0 									;comparamos el byte que esta en la direccion a la que apunta EAX con el '0' (estamos buscando el caracter de terminacion 0)
	jz finalizar										;Jump if Zero, si es 0 salta a 'finalizar'
	inc eax 											;si es diferente incrementamos el acumulador en 1
	jmp sigcar 											;salto incondicional al siguiente caracter

finalizar:
	sub eax,ebx											;restamos al valor inicial de memoria el valor final de memoria
	pop ebx 											;restablecer ebx
	ret 												;regresa al punto en que llamaron a la funcion

sprint:
	push edx 											;salvamos valor de edx
	push ecx 											;salvamos valor de ecx
	push ebx 											;salvamos valor de ebx
	push eax 											;salvamos valor de eax
	call strlen 										;llamamos a la funcion strlen

	mov edx,eax											;movemos la longitud de cadena a edx
	pop eax 											;traemos del stack el valor de eax
	mov ecx,eax 										;la direccion del mensaje a ecx
	mov ebx,1 											;salida standar
	mov eax,4 											;sys write
	int 80h 											;ejecuta

	pop ebx												;re establecemos ebx
	pop ecx												;re establecemos ecx
	pop edx												;re establecemos edx
	ret

quit:
	mov ebx,0 											;secuencia de salida
	mov eax,1 											;sys_exit
	int 80h 											;ejecuta