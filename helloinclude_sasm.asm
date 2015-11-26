;hello_include.asm
;;hola mundo con funciones
;autor: cristian samaniego
;fecha: 1/oct/2015

%include '/home/jonathan/assembler/funciones.asm'
	msj1 db 'hola mundo',0xA,0x0 						;primer mensaje
	msj2 db 'Ahora con funciones incluidas',0xA,0x0		;segundo mensaje
	msj3 db 'y nuevo empaque!!!',0xA,0x0 				;tercer mensaje

section .data
	GLOBAL main

main: 												;aqui comienza el programa
	mov eax,msj1 										;cargamos la direccion del primer mensaje a eax
	call sprint 										;llamamos al metodo para imprimir la cadena

	mov eax,msj2 										;cargamos la direccion del segundo mensaje a eax
	call sprint 										;llamamos al metodo para imprimir la cadena
	
	mov eax,msj3 										;cargamos la direccion del tercer mensaje a eax
	call sprint 										;llamamos al metodo para imprimir la cadena
	
	call quit 											;salida!
