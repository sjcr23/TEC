;Objetivo del procedimiento: llama a otros procedimientos para pedir coordenadas,
;coloca el simbolo en el tablero y verifica si hay ganador por parte del jugadorX
ciclodelJuegoX:
    call dibujarTablero
    
    call perdirCoordenadas
    call colocarSimboloX
    ; en dl esta la usado el X/O
    call verificarGaneVertical
    call verificarGaneHorizontal
    call verificarGaneDiagonales
    call verificarEmpate
    ret

;Objetivo del procedimiento: llama a otros procedimientos para pedir coordenadas,
;coloca el simbolo en el tablero y verifica si hay ganador por parte del jugadorO
ciclodelJuegoO:
    call dibujarTablero
    call perdirCoordenadas
    call colocarSimboloO
     ; en dl esta la usado el X/O
    call verificarGaneVertical
    call verificarGaneHorizontal
    call verificarGaneDiagonales
    call verificarEmpate
    ret

;Objetivo del procedimiento: vuelve a dejar el tablero como al inico, sin ninguna jugada
;Se usa en caso que alguien decida salirse en medio del juego.
resetJuego:
    mov edi, tablero    ;se pasa el tablero al registro edi 
    mov byte[edi],'1'   ;regresa a su valor original
    inc edi             ;se avanza a la siguiente posicion
    mov byte[edi],'2'
    inc edi
    mov byte[edi],'3'
    inc edi 
    mov byte[edi],'4'
    inc edi
    mov byte[edi],'5'
    inc edi
    mov byte[edi],'6'
    inc edi
    mov byte[edi],'7'
    inc edi 
    mov byte[edi],'8'
    inc edi 
    mov byte[edi],'9'
    ret

;Objetivo del procedimiento: recorre el tablero para encontrar si existe un empate
verificarEmpate:
    mov edi, tablero            ;se pasa el tablero al registro edi 
    cmp byte[edi],'1'           ;verifica si la posicion tiene cambio, paso del numero a O o X
    je salirVerificarEmpate     ;si no hay posicionada una O o X, no paso por cambios entonces aun falta posiciones del tablero por llenar
    inc edi                     ;seguir revisando en las demas posiciones en caso que esta posicion si tiene una O o X 
    cmp byte[edi],'2'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'3'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'4'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'5'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'6'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'7'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'8'
    je salirVerificarEmpate
    inc edi 
    cmp byte[edi],'9'
    je salirVerificarEmpate
    imprimir_pierde
    call dibujarTablero
    call exit
    salirVerificarEmpate:
        ret

;Objetivo del procedimiento: llama a dos procedimientos que revisan las diagonales
;e identifican si hay ganador

verificarGaneDiagonales:
    call verificarGanePrimeraDiagonal
    call verificarGaneSegundaDiagonal
    ret

;Objetivo del procedimiento: identifica si en una diagonal hay ganador 
;en el registro dl esta guardada la O o X
verificarGaneSegundaDiagonal:
    mov edi, tablero
    add edi, 2                              ;avanza para llegar al final de la primera fila
    
    ;Objetivo del procedimiento: si coincide el simbolo con el de la posicion se continua revisando
    verificarSegundaDiagonal:
        cmp byte[edi], dl                        
        je verificarSegundaDiagonal1
        jne salirVerificarSegundaDiagonal

    ;Objetivo del procedimiento: avanza para llegar al centro de la segunda fila
    ;si coincide el simbolo con el de la posicion del tablero, continua con la ultima fila
    verificarSegundaDiagonal1:
        add edi, 2                          
        cmp byte[edi], dl                   
        je verificarSegundaDiagonal2
        jne salirVerificarSegundaDiagonal

    ;Objetivo del procedimiento:avanza hasta la ultima fila en la primer columna
    ; si coincide, hay un ganador
    verificarSegundaDiagonal2:
        add edi, 2                          
        cmp byte[edi], dl                   
        je ganoSegundaDiagonal
        jne salirVerificarSegundaDiagonal
    
    ;Objetivo del procedimiento: Comprueba cual es el jugador ganador
    ganoSegundaDiagonal:            
        mov eax, simboloX
        cmp byte[eax],dl 
        je ganeSegundaDiagonalX
        mov eax, simboloO
        cmp byte[eax], dl
        je ganeSegundaDiagonalO
    
    ;Objetivo del procedimiento: Muestra el mensaje del ganador y se acaba el juego
    ganeSegundaDiagonalX:           
        printf nueva_linea,nl_len
        printf nueva_linea,nl_len
        imprimir_gane
        call dibujarTablero
        call exit

    ;Objetivo del procedimiento: Muestra el mensaje del ganador y se acaba el juego
    ganeSegundaDiagonalO:           
        printf nueva_linea,nl_len
        printf nueva_linea,nl_len
        imprimir_gane
        call dibujarTablero
        call exit
        
    salirVerificarSegundaDiagonal:
        ret

;Objetivo del procedimiento: identifica si en una diagonal hay ganador 
;en el registro dl esta guardada la O o X
verificarGanePrimeraDiagonal:
    mov edi, tablero                        ;se queda en la primer columna de la primer fila

    ;Objetivo del procedimiento: si coincide el simbolo con el de la posicion se continua revisando
    verificarPrimeraDiagonal:
        cmp byte[edi], dl                   
        je verificarPrimeraDiagonal1
        jne salirVerificarPrimeraDiagonal

    ;Objetivo del procedimiento:avanza hasta la mitad de la segunda fila y segunda columna
    ;si coincide el simbolo con el de la posicion se continua revisando
    verificarPrimeraDiagonal1:
        add edi, 4                          
        cmp byte[edi], dl                  
        je verificarPrimeraDiagonal2
        jne salirVerificarPrimeraDiagonal

    ;Objetivo del procedimiento: avanza a la ultima fila y columna 
    ;si coincide hay un ganador 
    verificarPrimeraDiagonal2:
        add edi, 4                          
        cmp byte[edi], dl                   
        je ganoPrimeraDiagonal
        jne salirVerificarPrimeraDiagonal
    
    ;Objetivo del procedimiento: Comprueba cual es el jugador ganador
    ganoPrimeraDiagonal:                    
        mov eax, simboloX                   
        cmp byte[eax],dl                    
        je ganePrimeraDiagonalX
        mov eax, simboloO
        cmp byte[eax], dl
        je ganePrimeraDiagonalO
    
    ;Objetivo del procedimiento: Muestra el msg del jugador ganador y como queda el tablero al final 
    ganePrimeraDiagonalX:                   
        imprimir_gane
        call dibujarTablero
        call exit
    
    ;Objetivo del procedimiento: Muestra el msg del jugador ganador y como queda el tablero al final 
    ganePrimeraDiagonalO:                   
        imprimir_gane
        call dibujarTablero
        call exit
        
    salirVerificarPrimeraDiagonal:
        ret
    


;Objetivo del procedimiento: revisa de forma vertical para identificar un ganador
verificarGaneVertical:      ; en dl esta X o O 
    mov edi, tablero
    mov ecx,2               ; cantidad de columnas restantes por revisar
    
    verificarV:
        cmp byte[edi], dl   ;revisa si coincide el dato
        je verificarV1
        inc edi             ;se incrementa para revisar la proxima columna
        cmp ecx,0           ;verificar si ya se reviso todas las columnas
        je salirVerificacionV
        dec ecx             ;se descuenta una columna que se acaba de revisar
        jmp verificarV

    ;Objetivo del procedimiento: en caso de no coincidir en toda la columna con los simbolos
    ;se devuelve a la siguiente columna en la primer fila 
    regresarPosicionV:      
        sub edi,2           
        jmp verificarV

    ;Objetivo del procedimiento: avanza a la siguiente fila en la misma columna
    ;comprueba si coincide
    verificarV1:                
        add edi, 3              
        cmp byte[edi], dl       
        je verificarV2
        jne regresarPosicionV   
    
    ;Objetivo del procedimiento: revisa la coincidencia de simbolos
    ; de la ultima fila en la misma columna
    verificarV2:
        add edi, 3              
        cmp byte[edi], dl 
        je ganoV
        jne regresarPosicionV

    ;Objetivo del procedimiento: revisa cual jugador es el ganador
    ganoV:                      
        mov eax, simboloX
        cmp byte[eax],dl 
        je ganeVerticalX
        mov eax, simboloO
        cmp byte[eax], dl
        je ganeVerticalO

    ;Objetivo del procedimiento:imprime mensaje del ganador X
    ganeVerticalX:                  
        imprimir_gane
        call dibujarTablero
        call exit
    
    ;Objetivo del procedimiento:imprime mensaje del ganador O
    ganeVerticalO:                 
        imprimir_gane
        call dibujarTablero
        call exit
        
    salirVerificacionV:
        ret


;Objetivo del procedimiento: revisa de forma horizontal para identificar un ganador
verificarGaneHorizontal:; en dl esta X o O 
    mov edi, tablero
    mov ecx,2               ;cantidad de filas restantes por revisar
    verificarH:
        cmp byte[edi], dl   ;revisa si coincide el dato
        je verificarH1
        cmp ecx,0
        je salirVerificacionH
        dec ecx             ;se resta la cantidad de filas por revisar
        add edi, 3          ;se incrementa para revisar la proxima fila
        jmp verificarH
    
    ;Objetivo del procedimiento: regresa a la primer columna en siguiente fila
    regresarPosicionH:      
        cmp ecx,0
        je salirVerificacionH
        add edi, 3
        jmp verificarH

    ;Objetivo del procedimiento: avanza a la siguiente columna en la misma fila para comprobar la coincidencia de simbolos
    ; en caso de no ser regresa al inicio de la fila
    verificarH1: 
        inc edi                 
        cmp byte[edi], dl      
        je verificarH2
        sub edi, 1              
        jmp regresarPosicionH

    ;Objetivo del procedimiento: avanza a la ultima columna de la fila para comprobar la coincidencia de simbolos
    ;en caso de no ser regresa al inicio de la fila
    verificarH2:        
        inc edi                 
        cmp byte[edi], dl 
        je ganoH
        sub edi, 2               
        jmp regresarPosicionH
       
    ;Objetivo del procedimiento: revisa cual jugador es el ganador
    ganoH:                       
        mov eax, simboloX
        cmp byte[eax],dl 
        je ganeHorizontalX
        mov eax, simboloO
        cmp byte[eax], dl
        je ganeHorizontalO

    ;Objetivo del procedimiento: imprime mensaje del ganador X   
    ganeHorizontalX:
        imprimir_gane
        call dibujarTablero
        call exit
    
    ;Objetivo del procedimiento:imprime mensaje del ganador O
    ganeHorizontalO:
        imprimir_gane
        call dibujarTablero
        call exit

    salirVerificacionH:
        ret


;Objetivo del procedimiento: limpiar y asignar datos antes de empezar a formar el tablero
dibujarTablero:
    printf nueva_linea,nl_len
    printf nueva_linea,nl_len
    xor ecx, ecx
    mov ecx, 2          ;cantidad restante de filas y columnas por imprimir
    mov edi, tablero
    call formartablero ; forma el tablero en pantalla
    ret

;Objetivo del procedimiento: formar primera parte del tablero y comprobar si hay O o X ya posicionadas.    
formartablero:
    mov esi,1
    tablerodelJuego:
        push rcx                           ;se hace un push porque el printf modifica el registro ecx
        printf underscore, underscore_len
        cmp byte[edi], 'X'
        je ponerSignoX
        cmp byte[edi], 'O'
        je ponerSignoO
        inc edi
        printf espacioB, espacioB_len
        jmp continuarTablero

;Objetivo del procedimiento: imprimir la X en el tablero
    ponerSignoX:
        printf simboloX, simboloX_len
        inc edi
        jmp continuarTablero
;Objetivo del procedimiento: imprimir la O en el tablero
    ponerSignoO:
        printf simboloO, simboloO_len
        inc edi
        jmp continuarTablero

;Objetivo del procedimiento: formar la parte final del tablero y comprobar si hay O o X ya posicionadas.
    continuarTablero:
        printf underscore, underscore_len
        printf pipe, pipe_len
        pop rcx                     ;ya se realizaron los prints entonces se vuelve a sacar el dato de la pila
        cmp esi,0
        je tablero2
        dec esi
        jmp tablerodelJuego

    ;Objetivo del procedimiento: revisa si se debe imprimir una O o X 
    tablero2:
        push rcx                            ;se hace un push porque el printf modifica el registro ecx
        printf underscore, underscore_len
        cmp byte[edi], 'X'
        je ponerSignoX2
        cmp byte[edi], 'O'
        je ponerSignoO2
        inc edi
        printf espacioB, espacioB_len

    ;Objetivo del procedimiento: terminar de formar el tablero
    continuarTablero2:
        printf underscore, underscore_len
        printf cambioLinea, cambioLinea_len
        pop rcx                             ;;ya se realizaron los prints entonces se vuelve a sacar el dato de la pila
        cmp ecx,0
        je terminarTablero
        dec ecx
        jmp formartablero
    
    ;Objetivo del procedimiento: imprimir la X en el tablero
    ponerSignoX2:
        printf simboloX, simboloX_len
        inc edi
        jmp continuarTablero2

    ;Objetivo del procedimiento: imprimir la O en el tablero
    ponerSignoO2:
        printf simboloO, simboloO_len
        inc edi
        jmp continuarTablero2
    terminarTablero:
        ret
    
;Objetivo del procedimiento: pide las coordenadaY para colocar Y o X en el tablero
;Verifica que el dato sea valido
perdirCoordenadas:
    printf nueva_linea,nl_len
    printf nueva_linea,nl_len
    printf turnoX, turnoX_len
    printf turnoO, turnoO_len
    printf msgCoordenadaY, msgCoordenadaY_len
    scanf coordenadaY
        
    mov al,byte[coordenadaY] 
    cmp al, '0'
    je primeraFila
    cmp al, '1'
    je segundaFila
    cmp al, '2'
    je terceraFila
    cmp al, 27
    je regresarMenuPrincipal
    
    ;Objetivo del procedimiento: imprime si los datos estan mal y los vuelve a pedir
    errorInsertarCoordenadaY:
        printf errorCoordenada, errorCoordenada_len
        jmp perdirCoordenadas
    
    ;Objetivo del procedimiento: pedir la coordenada X en la primer fila
    primeraFila:
        printf msgCoordenadaX, msgCoordenadaX_len
        scanf coordenadaX
        cmp byte[coordenadaX], '0'
        je asignarCero
        cmp byte[coordenadaX], '1'
        je asignarUno
        cmp byte[coordenadaX], '2'
        je asignarDos
        cmp byte[coordenadaX], 27
        je regresarMenuPrincipal
        printf errorCoordenada, errorCoordenada_len
        jmp primeraFila

    ;Objetivo del procedimiento: pedir la coordenada X en la segunda fila
    segundaFila:
        printf msgCoordenadaX, msgCoordenadaX_len
        scanf coordenadaX
        cmp byte[coordenadaX], '0'
        je asignarTres
        cmp byte[coordenadaX], '1'
        je asignarCuatro
        cmp byte[coordenadaX], '2'
        je asignarCinco
        cmp byte[coordenadaX], 27
        je regresarMenuPrincipal
        printf errorCoordenada, errorCoordenada_len
        jmp segundaFila

    ;Objetivo del procedimiento: pedir la coordenada X en la tercer fila
    terceraFila:
        printf msgCoordenadaX, msgCoordenadaX_len
        scanf coordenadaX
        cmp byte[coordenadaX], '0'
        je asignarSeis
        cmp byte[coordenadaX], '1'
        je asignarSiete
        cmp byte[coordenadaX], '2'
        je asignarOcho
        cmp byte[coordenadaX], 27
        je regresarMenuPrincipal
        printf errorCoordenada, errorCoordenada_len
        jmp terceraFila

    ;Objetivo del procedimiento: resetear el juego y volver al menu principal
    regresarMenuPrincipal: 
        printf nueva_linea,  nl_len
        imprimir_pierde
        call resetJuego
        call MenuInicio
    
    ;Objetivo del procedimiento: una vez procesadas las coordenadas, se hacen jmps para asignar numeros
    ; al registro eax que corresponden a las posiciones del tablero(numeros entre 0 a 8)
    asignarCero:
        mov eax,0
        jmp finalizarCoordenadas
    asignarUno:
        mov eax,1
        jmp finalizarCoordenadas

    asignarDos:
        mov eax,2
        jmp finalizarCoordenadas
    asignarTres:
        mov eax,3
        jmp finalizarCoordenadas
    asignarCuatro:

        mov eax,4
        jmp finalizarCoordenadas
    asignarCinco:
        mov eax,5
        jmp finalizarCoordenadas
    asignarSeis:
        mov eax,6
        jmp finalizarCoordenadas
    asignarSiete:
        mov eax,7
        jmp finalizarCoordenadas
    asignarOcho:
        mov eax,8
        jmp finalizarCoordenadas
    finalizarCoordenadas:
        ret

;Objetivo del procedimiento:colocar el simbolo X en la posicion correspondiente
;en eax esta guardado el numero del tablero
colocarSimboloX:
    mov ebx, simboloX
    mov dl,byte[ebx]
    mov ecx, tablero
    add ecx, eax 
    cmp byte[ecx],'X'
    je espacioOcupado
    cmp byte[ecx],'O'
    je espacioOcupado
    mov [ecx], dl
    jmp salidaColocarSimboloX
    ;Objetivo del procedimiento: en caso de que ya este ocupado el espacio
    ;hace un print para comunicarlo a los jugadores y llama el proceso para volver a pedirla
    espacioOcupado:
        printf msgEspacioOcupado,msgEspacioOcupado_l 
        call ciclodelJuegoX
    salidaColocarSimboloX:
    ret 

;Objetivo del procedimiento:colocar el simbolo X en la posicion correspondiente
;en eax esta guardado el numero del tablero
colocarSimboloO:
    mov ebx, simboloO
    mov dl,byte[ebx]
    mov ecx, tablero
    add ecx, eax 
    cmp byte[ecx],'X'
    je espacioOcupadoO
    cmp byte[ecx],'O'
    je espacioOcupadoO
    mov [ecx], dl
    jmp salidaColocarSimboloO
    ;Objetivo del procedimiento: en caso de que ya este ocupado el espacio
    ;hace un print para comunicarlo a los jugadores y llama el proceso para volver a pedirla
    espacioOcupadoO:
        printf msgEspacioOcupado,msgEspacioOcupado_l 
        call ciclodelJuegoO
    salidaColocarSimboloO:
    ret 