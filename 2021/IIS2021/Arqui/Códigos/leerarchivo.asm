%macro print 2
     MOV eax, sys_write
     MOV ebx, stdout
     MOV ecx, %1
     MOV edx, %2 
     int 0x80
%endmacro


section .data
    sys_exit  EQU 1
    sys_read  EQU 3
    sys_write EQU 4
    stdin     EQU 0
    stdout    EQU 1
    EOL       EQU 10

    filename1 db 'baja.txt', 0h    
    filename2 db 'media.txt',0h
    filename3 db 'alta.txt',0h
  
    nueva_linea db ' ',10, 13
    nuevalinea_len EQU $-nueva_linea

    palabra db 'Palabra: ',0
    palabra_len EQU $-palabra

    letraAdivinar db 'Digite una letra:',0
    letraAdivinar_len EQU $-letraAdivinar

    exito db 'Palabra encontrada',10,13
    exito_len EQU $-exito

    prueba1 db 'sss ',0
    prueba1_len EQU $-prueba1

    msgLetrasUsadas db 'Letras Utilizadas:'
    msgLetrasUsadas_len EQU $-msgLetrasUsadas

    msgDificultad db 'Seleccione la dificultad:',10, 13
    msgDificultad_len EQU $-msgDificultad

    msgBajo db '1.Bajo',10, 13
    msgBajo_len EQU $-msgBajo
    msgMedio db '2.Medio',10, 13
    msgMedio_len EQU $-msgMedio
    msgAlto db '3.Alto',10, 13
    msgAlto_len EQU $-msgAlto

section .bss
    fileContents resb 255,                              ;variable to store file contents
    file_len EQU $-fileContents                         ;contenido de todo el archivo

    prueba resb 255
    prueba_len EQU $-prueba

    letraSolicita resb 255                              ;guardar las letras solicitadas por el usuario
    letraSolicitada_len EQU $-letraSolicita
    
    input resb 1                                        ;guardar input
    input_len EQU $- input
    
    palabraSeleccionada resb 255                        ;palabra seleccionada del archivo
    palabraSeleccionada_len EQU $-palabraSeleccionada
    
    palabraAdivinar resb 255                            ; espacios en blanco
    palabraAdivinar_len EQU $-palabraAdivinar
    
    letrasUtilizadas resb 255
    letrasUtilizadas_len EQU $-letrasUtilizadas


section .text
global  _start
_start:

solicitarDificultad:;seleccionar la dificultad
    print nueva_linea, nuevalinea_len
    print msgDificultad, msgDificultad_len
    print msgBajo, msgBajo_len
    print msgMedio, msgMedio_len
    print msgAlto, msgAlto_len
    
    ;input para la dificultad
    MOV edx, input_len    ; Salida de linux
    MOV ecx, input        ; Muevo el input a ECX
    MOV ebx, stdin        ; Preparo el out
    MOV eax, sys_read     ; Opción de sys_read
    int 0x80              ; Kernel linux  

    ;seleccion de la dificultad
    mov al, byte[input]
    cmp al,'1'
    je abrirBaja
    cmp al,'2'
    je abrirMedio
    cmp al,'3'
    je abrirAlto
    jne solicitarDificultad ; no es ninguna de las 3 opciones


abrirBaja:                  ;abrir el archivo de bajo.txt
    mov ecx, 0              
    mov ebx, filename1
    mov eax, 5
    int 80h

    mov edx, 128            ; numero de bytes a leer- one for each letter of the file contents
    mov ecx, fileContents   ; move the memory address of our file contents variable into ecx
    mov ebx, eax            ; move the opened file descriptor into EBX
    mov eax, 3              ; invoke SYS_READ (kernel opcode 3)
    int 80h                 ; llamar al kernel
    jmp generarRandom

abrirMedio:                 ;abrir el archivo media.txt
    mov ecx, 0              
    mov ebx, filename2      ;nombre del archivo que se abre.
    mov eax, 5
    int 80h

    mov edx, 128            ; numero de bytes a leer
    mov ecx, fileContents   ; mover la dirección de memoria de la variable de contenido de archivo a ecx
    mov ebx, eax            ; mover el descriptor de archivo abierto a EBX
    mov eax, sys_read       ; SYS_READ 
    int 80h                 ; llamar al kernel
    jmp generarRandom

abrirAlto:                  ; Abrir el archivo  alto.txt
    mov ecx, 0              
    mov ebx, filename3
    mov eax, 5
    int 80h

    mov edx, 128            ; numero de bytes a leer- one for each letter of the file contents
    mov ecx, fileContents   ; move the memory address of our file contents variable into ecx
    mov ebx, eax            ; move the opened file descriptor into EBX
    mov eax, 3              ; invoke SYS_READ (kernel opcode 3)
    int 80h                 ; llamar al kernel


generarRandom:                     ; generar la posicion random para seleccionar del txt.
    xor eax,eax 
    xor ecx,ecx  
    xor ebx,ebx 
    rdtsc 
    and eax,0x0005                 ;despues de generar random, poder limite a 5
    cmp eax,0
    je generarRandom               ;evitar que el numero sea 0, este entre 1 y 5 
    mov ecx, eax                   ;colocar el numero que sera la posicion de la palabra
    mov eax, fileContents          ;el contenido del archivo se pasa a eax
    mov ebx, palabraSeleccionada   ;en ebx se va a guardar la palabra seleccionada del txt
    mov edx, 1                     ;llevar la cuenta de las palabras que se han recorrido
    
seleccionarPalabra:
    cmp ecx, edx        ; saber si se encontro la posicion de la palabra buscada
    je formarPalabra    ; se encontro la posicion, se debe formar la palabra
    cmp byte[eax],','   ; la coma separa las palabras en el txt
    jne seguirLetra     ; seguir en el recorrido de letra en letra
    je incrementaLetra  ; se encontro una coma, hay una palabra nueva

seguirLetra:
    inc eax                 ;continuar a la siguiente letra
    jmp seleccionarPalabra  

incrementaLetra:
    inc edx                 ;se empieza una nueva palabra
    inc eax                 ;continua con el siguiente caracter
    jmp seleccionarPalabra

formarPalabra:              ;una vez encontrada la posicion se forma la palabra
    cmp byte[eax],','       ;se acabo la palabra
    je continua             ;salir de la seleccion de palabra
    mov cl,byte[eax]          
    mov byte[ebx], cl       ;formar la palabra 
    inc eax                 ;seguir recorriendo el contenido del txt para formar la palabra    
    inc ebx
    jmp formarPalabra

continua:
    print   palabraSeleccionada, palabraSeleccionada_len
    mov     ebx, palabraSeleccionada  ; move the address of our message string into EBX
    mov     eax, ebx                  ; move the address in EBX into EAX as well (Both now point to the same segment in memory)
    mov     ecx,1                     ; cx va a contener la longitud del string
    
nextchar:
    cmp     byte [eax], 0   ; compare the byte pointed to by EAX at this address against zero (Zero is an end of string delimiter)
    jz      prepararCambio  ; jump (if the zero flagged has been set) to the point in the code labeled 'finished'
    inc     eax             ; increment the address in EAX by one byte (if the zero flagged has NOT been set)
    inc     ecx
    jmp     nextchar        ; jump to the point in the code labeled 'nextchar'

prepararCambio:   
    mov     ebx, palabraAdivinar; agregar la cantidad de espacios en blanco en palabraAdivinar.
    mov     eax, ebx 

imprimeBlanco:                  ;rellenar palabraAdivinar con espacios y lineas 
    dec ecx
    cmp ecx,0                   ;en ecx se guardaba la longitud del string
    jz comparacion              
    mov byte[eax],'_'           ;agregar el _
    inc eax                     ;se sigue recorriendo el string
    mov byte[eax],' '           ;agregar espacio en blanco
    inc eax                     ;seguir avanzano en el string
    jmp imprimeBlanco               
    

comparacion:                            ;print de las indicaciones y datos en pantalla
    
    print nueva_linea, nuevalinea_len
    print palabra, palabra_len
    print palabraAdivinar, palabraAdivinar_len  ; palabra con espacios en blanco
    print nueva_linea, nuevalinea_len
    print nueva_linea, nuevalinea_len
    print nueva_linea, nuevalinea_len

input1:
    print letraAdivinar, letraAdivinar_len; pedir la letra
    MOV edx, input_len    ; Salida de linux
    MOV ecx, input        ; Muevo el input a ECX
    MOV ebx, stdin        ; Preparo el out
    MOV eax, sys_read     ; Opción de sys_read
    int 0x80              ; Kernel linux


    mov ebx, palabraSeleccionada        
    mov eax, ebx            ; en eax queda la palabra sacada del txt
    mov cl, byte[input]     ; paso el input a registro de 8 bits
    mov ebx, palabraAdivinar; en ebx queda la palabra con los espacios en blanco
 
revisarP:                   ;revisa si la letra del input esta en el string
    cmp byte[eax], cl 
    je encontro             ;si se encuentra en el string
    cmp byte[eax],0
    je findeRevision  
    inc eax                 ;avanzar en los caracteres de la palabra
    inc ebx
    inc ebx
    jmp revisarP
 
encontro:               ; ya confirmada que esta en el string, se hace el cambio con los espacio en blanco
    mov byte[ebx], cl   ; se coloca la letra en lugar del _
    inc ebx 
    inc ebx             ;se avanza en 2 por el espacio en blanco  
    inc eax             ;seguir revisando en el string
    jmp revisarP        ;seguir revisando la palabra en caso que haya mas de una

findeRevision:                      ;ya se termina de pedir letras
    ;jmp comparacion
    mov eax, palabraAdivinar        ;palabra que a incio estaba con espacios en blanco
    mov ecx, palabraSeleccionada    ;contenido del archivo
      
verificarPalabraCompleta:   ;verificar la palabra completa.
    mov dl, byte[eax]
    cmp byte[ecx],dl        ;si corresponde a la palabra
    jne comparacion         
    cmp byte[ecx], 0        
    je exitoEnJuego
    inc ecx
    inc eax
    inc eax 
    jmp verificarPalabraCompleta

exitoEnJuego:                  ;palabra encontrada con exito
    print exito, exito_len      
    jmp solicitarDificultad    ;vuelve al menu.

exit:
    ;print palabraAdivinar, palabraAdivinarlen
     mov eax, sys_exit     ; Código de la función "sys_exit".
     xor ebx, ebx          ; Valor de retorno de la función.
     int 0x80              ; Ejecuciuón de la interrupción.
