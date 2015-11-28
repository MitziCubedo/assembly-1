;promedio.asm calcula el promedio de un alumno
;autores: Cristian Samaniego, Mitzi Sanchez
;fecha: 28/11/15

section .data
    msjNombre db "Nombre del Alumno: ", 0x0     ;declaramos msjNombre
    msjCalificacion db  "Calificacion ",0x0     ;declaramos msjCalificacion
    msjPromedio db "Promedio: ", 0x0            ;declaramos msjPromedio
    msjSemestre db "Semestre: ",0x0             ;declaramos msjSemestre
    msjAprobado db "Aprobado", 0x0              ;declaramos msjAprobado
    msjReprobado db "Reprobado", 0x0            ;declaramos msjReprobado
    msjDosPuntos db ": ", 0x0                    ;declaramos msjDosPuntos
    msjSeparador db "-------------------------" ;declaramos msjSeparador
    
    sys_read    equ 3
    stdin       equ 0

section .bss
    Buffer resb 20                 ;reserva 20bytes
    BufferLen equ $-Buffer         ;determina la longitud de la variable Buffer

section .text
    global _start

    
_start:
    pop ecx ;# args
    pop eax ;nomb programa
    dec ecx ;restamos 1
    pop eax ;# califs

    call atoi               ;convertimos el caracter a numero
    cmp EAX, 0              ;comparamos EAX con cero 
    jz quit                 ;si no hay calificaciones, salimos
    mov EBX, EAX            ;movemos EAX a EDX
    mov EAX, msjNombre      ;preparamos para imprimir 
    call sprint             ;imprimimos msjNombre
    mov ECX, Buffer         ;direccion de Buffer a ECX
    mov EDX, BufferLen      ;longitud de Buffer a EDX 
    call LeerTexto          ;llamamos a la funcion LeerTexto
    push EAX                ;guardamos el nombre del alumno en el stack
    mov ECX, 1              ;movemos uno a ECX (num para las calificaciones)
    mov EDX, 0              ;iniciamos EDX en cero

sigCalif:
    cmp ECX, EBX                        ;comparamos ECX con EDX
    jg impReporte                       ;saltamos a imprimir el reporte
    mov EAX, msjCalificacion            ;preparamos para imprimir
    call sprint                         ;imprimimos la primera parte del mensaje
    mov EAX, ECX                        ;preparamos para imprimir el numero de calif
    call iprint                         ;imprimimos el numero
    mov EAX, msjDosPuntos               ;preparamos para imprimir
    call sprint                         ;imprimimos dos puntos
    push ECX                            ;guardamos el num de calif en el stack
    push EBX                            ;guardamos el num total de califs en el stack
    mov ECX, Buffer                     ;direccion de Buffer a ECX
    mov EDX, BufferLen                  ;longitud de Buffer a EDX 
    call LeerTexto                      ;llamamos a la funcion LeerTexto
    call atoi                           ;convertimos la calif a entero
    add EDX, EAX                        ;sumamos la calif al total
    pop EBX                             ;recuperamos el num total de califs
    pop ECX                             ;recuperamos el num de calif
    inc ECX                             ;incrementamos ECX en uno
    jmp sigCalif                        ;iteramos

impReporte:
    mov EAX, msjSeparador               ;preparamos para imprimir
    call sprint                         ;imprimimos msjSeparador
    mov EAX, msjNombre                  ;preparamos para imprimir
    call sprint                         ;imprimimos msjNombre
    pop EAX                             ;sacamos el nombre del stack
    call sprintLF                       ;imprimimos el nombre del alumno
    mov EAX, msjPromedio                ;preparamos para imprimir
    call sprint                         ;imprimimos msjPromedio 
    mov EAX, EDX                        ;movemos el total para dividirlo
    div EBX                             ;dividimos el total entre el num de califs
    call iprintLF                       ;imprimimos el promedio
    mov EDX, EAX                        ;movemos EAX a EDX
    mov EAX, msjSemestre                ;preparamos para imprimir
    call sprint                         ;imprimimos msjSemestre
    cmp EDX, 60                         ;comparamos el promedio con 100
    jl impReprobado                     ;salta a impReprobado
    mov EAX, msjAprobado                ;preparamos para imprimir
    call sprintLF                       ;imprimimos msjAprobado
    call quit                           ;salimos

impReprobado:
    mov EAX, msjReprobado               ;preparamos para imprimir
    call sprintLF                       ;imprimimos msjReprobado
    call quit                           ;salimos

;funciones a utilizar 
strlen:             ;funcion strlen
    push EBX        ;salvamos el valor de EBX en la pila/stack
    mov EBX, EAX    ;copiamos la direccion del mensaje a EBX

atoi:
    push EBX        ;preservamos EBX
    push ECX        ;preservamos ECX
    push EDX        ;preservamos EDX
    push ESI        ;preservamos ESI
    mov ESI,EAX     ;nuestro numero a convertir va a EAX
    mov EAX, 0      ;inicializamos a cero EAX
    mov ECX, 0      ;inicializamos a cero ECX
    
ciclomult:          ;ciclo de multiplicacion
    xor EBX, EBX    ;reseteamos a 0 EBX, tanto BH como BL
    mov BL, [ESI+ECX] ;movemosun solo byte a la parte baja de EBX
    cmp BL, 48      ;comparamos con ASCII '0'
    jl terminarP   ;si es menor, saltamos a finalizado
    cmp BL, 57      ;comparamos con ASCII '9'
    jg terminarP  ;si es mayor, saltamos a finalizado
    cmp BL, 10      ;comparamos con linefeed
    je terminarP  ;si es igual, saltamos a finalizado
    cmp BL, 0       ;comparamos con caracter null (fin de cadena)
    jz terminarP   ;si es cero saltamos a finalizado 
    
    sub BL, 48      ;convertimos el caracter en entero (restamos 48)
    add EAX, EBX    ;agregamos el valor a EAX
    mov EBX, 10     ; movemos el decimal a 10 a EBX
    mul EBX         ;multiplicamos EAX por EBX para obtener el lugar decimal
    inc ECX         ;incrementamos ECX (contador)
    jmp ciclomult   ;seguimos nuestro ciclo de multiplicacion       
    
terminarP:
    mov EBX, 10     ;movemos el valor decimal 10 a EBX
    div EBX         ;dividimos EAX por 10
    pop ESI         ;re establecemos el valor de ESI
    pop EDX         ;re-establecemos el valor de EDX
    pop ECX         ;re-establecemos el valor de ECX
    pop EBX         ;re-establecemos el valor de EBX
    ret

sprint:
    push EDX        ;salvamos valor de EDX
    push ECX        ;salvamos valor de ECXX
    push EBX        ;salvamos valor de EBXX
    push EAX        ;salvamos valor de EAX
    call strlen     ;llamamos la funcion strlen
    
    mov EDX, EAX    ;movemos la longitud de cadena a EDX
    pop EAX         ;traemos del stack el valor de EAX
    mov ECX, EAX    ;la direccion del mensaje a ECX
    mov EBX, 1      ;descriptor de archivo (stdout)
    mov EAX, 4      ;sys_write
    int 80h         ;sys_exit
    
    pop EBX         ;re-establecemos EBX
    pop ECX         ;re establecemos ECX
    pop EDX         ;re-establecemos EDX
    ret

sprintLF:   
    call sprint     ;llama e imprime el mensaje
    
    push EAX        ;salvamos el valor del acumulador (EAX), vamos a utilizarlo en esta funcion
    mov EAX,0xA     ;Hexadecimal para caracter de LineFeed
    push EAX        ;salvamos el 0xA en el stack    trucoooo
    mov EAX, ESP    ;pasamos direccion de0xA en el stack  // lo que apunta ESP(es la direccion del ultimo lugar de la pila) a EAX
    call sprint     ;llama e imprime linefeed 
    pop EAX         ;recuperamos el caracter 0xA
    pop EAX         ;recuperamos el valor original de 0xA
    ret             ;regresamos

iprint:
    push eax                ;salvamos eax en el stack (acumulador)
    push ecx                ;salvamos ecx en el stack (contador)   cuantos bytes echamos al stack
    push edx                ;salvamos edx en el stack (data)
    push esi                ;salvamos esi en el stack (source index)
    mov ecx, 0              ;vamos a contar cuantos bytes necesitamos imprimir
    
dividirLoop:
    inc ecx                 ;incrementar en 1 ecx
    mov edx, 0              ;limpiamos edx
    mov esi, 10             ;guardamos 10 en esi, vamos a dividir entre 10
    idiv esi                ;divide eax entre esi, siempre divide a EAX lo que este en eax lo divide con el vqlor de esi    
    add EDX, 48             ;agregamos el caracter 48 '0' 
    push EDX                ;la representación en ASCII de nuestro numero, lo guarda en el stack como caracter
    cmp EAX, 0              ;se puede dividir mas el numero entero ?
    jnz dividirLoop         ;jump if not zero (salta si no es cero)

imprimirLoop:
    dec ECX                 ;vamos a contar hacia abajo cada byte en el stack
    mov EAX, ESP            ;apuntador del stack a EAX
    call sprint             ;llamamos a la funcion sprint
    pop EAX                 ;removemos el ulitmo caracter del stack y lo mandamos a el registro EAX
    cmp ECX, 0              ;ya imprimimos todos los bytes del stack?
    jnz imprimirLoop        ;todavia hay numero que imprimir
    
    pop ESI                 ;re-establecemos el valor de ESI
    pop EDX                 ;re-establecemos el valor de EDX
    pop ECX                 ;re-establecemos el valor de ECX
    pop EAX                 ;re-establecemos el valor de EAX
    ret

iprintLF:
    call iprint         ;imprimimos el nuevo numero
    push EAX            ;salvamos el dato que traemos en el acumulador
    mov EAX, 0xa        ;copiamos el código de linefeed a EAX
    push EAX            ;salvamos el linefeed en el stack
    mov EAX, ESP        ;copiamos el apuntador del stack a EAX
                        ;estamos apuntando a una dirección de memoria
    call sprint         ;imprimimos el linefeed
    pop EAX             ;removemos el linefeed del stack
    pop EAX             ;restablecemos el dato que traiamos en el acumulador
    ret             
  
LeerTexto:
    mov EBX, stdin      ;Leemos de Standard Input
    mov EAX, sys_read   ;Funcion de Sistema Leer
    int 80h             ;Pedir a sistema operativo realizar lectura
    ret 

quit:   
    mov EBX,0           ;iniciamos secuencia de salida
    mov EAX,1           ;sys_exit
    int 80h             ;ejecuta







