; MACROS
    ; MACROS PARA LLAMAR AL KERNEL
        ;Objetivo del procedimiento: Imprimir un string en pantalla.
        %macro printf 2
            MOV     EAX,     sys_write          ; Opción 4 de las INTerrupciones del Kernel.
            MOV     EBX,     stdout             ; Standar output.
            MOV     ECX,     %1                 ; mensaje.
            MOV     EDX,     %2                 ; Longitud.
            INT     0x80
        %endmacro

        ;Objetivo del procedimiento: Leer el input, con un dato donde guardarlo.
        %macro scanf 1
            MOV     EAX,     sys_read      ; Opción 3 de las INTerrupciones del Kernel.
            MOV     EBX,     stdin         ; Standar input.
            MOV     ECX,     %1            ; Dirección de memoria reservada para almacenar nuestro input (conocido como buffer).
            MOV     EDX,     8             ; Número de BYTEs a leer.
            INT     0x80
        %endmacro
    ;

    ; MACROS PARA IMPRIMIR mensajeS
        ;Objetivo del procedimiento: imprimir en pantalla las opciones para empezar el juego
        %macro imprimir_opciones 0
            printf  nueva_linea,  nl_len

            printf  Gopt1      ,  Glen1
            printf  nueva_linea,  nl_len
            printf  Gopt2      ,  Glen2
            printf  Gopt3      ,  Glen3

            printf  nueva_linea,  nl_len
            printf  Gopt4      ,  Glen4
        %endmacro

        ; Objetivo del procedimiento: Imprimir el mensaje de bienvenida.
        %macro imprimir_bienvenida 0
            printf  nueva_linea,  nl_len
            printf  titulo0    ,  ti_len0

            printf  titulo1    ,  ti_len1
            printf  titulo2    ,  ti_len2
            printf  titulo3    ,  ti_len3
            printf  titulo4    ,  ti_len4
            printf  titulo5    ,  ti_len5
            printf  titulo6    ,  ti_len6
        %endmacro

        ; Objetivo del procedimiento: Imprimir el mensaje de gane.
        %macro imprimir_gane 0
            printf  nueva_linea, nl_len

            printf  win0       ,  wlen0
            printf  win1       ,  wlen1
            printf  win2       ,  wlen2
            printf  win3       ,  wlen3
            printf  win4       ,  wlen4
            printf  win5       ,  wlen5
            printf  win6       ,  wlen6
            printf  win7       ,  wlen7
        %endmacro

        ; Objetivo del procedimiento: Imprimir el mensaje de pierde. [los significa: lose]
        %macro imprimir_pierde 0
            ; NUEVA LÍNEA
            printf  nueva_linea, nl_len

            ; MENSAJE
            printf  los0       ,  flen0
            printf  los1       ,  flen1
            printf  los2       ,  flen2
            printf  los3       ,  flen3
            printf  los4       ,  flen4
            printf  los5       ,  flen5
            printf  los6       ,  flen6
            printf  los7       ,  flen7
            printf  los8       ,  flen8
        %endmacro

        ; Objetivo del procedimiento: Imprimir el mensaje de depedida.
        %macro imprimir_despedida 0
            ; NUEVA LÍNEA
            printf  nueva_linea,  nl_len

            ; MENSAJE
            printf  bye0       ,  blen0
            printf  bye1       ,  blen1
            printf  bye2       ,  blen2
            printf  bye3       ,  blen3
            printf  bye4       ,  blen4
            printf  bye5       ,  blen5
            printf  bye6       ,  blen6
        %endmacro
    ;
;

section .data 
    ; -- OPCIONES DEL KERNEL -----------------------------------------------------------------------------
        sys_exit        EQU 	1
        sys_read        EQU 	3
        sys_write       EQU 	4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU 	0
        stdout          EQU 	1
    ;
    
    ; -- OTRAS VARIABLES ---------------------------------------------------------------------------------
        EOL             EQU 	10
        nueva_linea     DB 	    10, 13 
        nl_len          EQU	    $- nueva_linea
    ;

    ; -- NOMBRE DEL JUEGO --------------------------------------------------------------------------------
        titulo0         DB 	    "  ---------------------- BIENVENIDO AL JUEGO ------------------------ ", EOL
        ti_len0         EQU     $- titulo0

        titulo1         DB  	"   _____    _______       ____            ____  ", EOL     
        ti_len1         EQU 	$- titulo1                                                                          

    	titulo2         DB  	"  / ____|  |__   __|     / __ \          / __ \ ", EOL     
        ti_len2         EQU 	$- titulo2                                                                          

    	titulo3         DB 	    " | |  __  __ _| | ___   | |  | |_      _| |  | |", EOL     
        ti_len3         EQU	    $- titulo3                                                                          

    	titulo4         DB  	" | | |_ |/ _` | |/ _ \  | |  | \ \ /\ / / |  | |", EOL     
        ti_len4         EQU 	$- titulo4                                                                          

    	titulo5         DB  	" | |__| | (_| | | (_) | | |__| |\ V  V /| |__| |", EOL     
        ti_len5         EQU 	$- titulo5                                                                          

    	titulo6         DB  	"  \_____|\__,_|_|\___/   \____/  \_/\_/  \____/ ", EOL, EOL    
        ti_len6         EQU 	$- titulo6
    ;

   
    ; -- DESPEDIDA DEL JUEGO -----------------------------------------------------------------------------    
        bye0            DB  	"  -------------------------- HASTA  LUEGO --------------------------", EOL     
        blen0           EQU 	$- bye0

        bye1            DB  	"                                 _ _   __      ", EOL     
        blen1           EQU 	$- bye1

    	bye2            DB  	"                        /\      | (_) /_/      ", EOL     
        blen2           EQU 	$- bye2

    	bye3            DB 	    "                       /  \   __| |_  ___  ___ ", EOL     
        blen3           EQU	    $- bye3

    	bye4            DB  	"                      / /\ \ / _` | |/ _ \/ __|", EOL     
        blen4           EQU 	$- bye4

    	bye5            DB  	"                     / ____ \ (_| | | (_) \__ \", EOL     
        blen5           EQU 	$- bye5

    	bye6            DB  	"                    /_/    \_\__,_|_|\___/|___/", EOL, EOL     
        blen6           EQU 	$- bye6
    ;


    ; -- MENSAJE DE GANE  --------------------------------------------------------------------------------    
        win0            DB  	"  ----------------------- TENEMOS UN GANADOR -----------------------", EOL     
        wlen0           EQU 	$- win0

        win1            DB  	"     ______   _ _      _     _           _                  __  ", EOL     
        wlen1           EQU 	$- win1

    	win2            DB  	"    |  ____| | (_)    (_)   | |         | |              _  \ \ ", EOL     
        wlen2           EQU 	$- win2

    	win3            DB 	    "    | |__ ___| |_  ___ _  __| | __ _  __| | ___  ___    (_)  | |", EOL     
        wlen3           EQU	    $- win3

    	win4            DB  	"    |  __/ _ \ | |/ __| |/ _` |/ _` |/ _` |/ _ \/ __|        | |", EOL     
        wlen4           EQU 	$- win4

    	win5            DB  	"    | | |  __/ | | (__| | (_| | (_| | (_| |  __/\__ \    _   | |", EOL     
        wlen5           EQU 	$- win5

    	win6            DB  	"    |_|  \___|_|_|\___|_|\__,_|\__,_|\__,_|\___||___/   (_)  | |", EOL,    
        wlen6           EQU 	$- win6

    	win7            DB  	"                                                            /_/ ", EOL, EOL
        wlen7           EQU 	$- win7
    ;


    ; -- MENSAJE DE PIERDE  ------------------------------------------------------------------------------
        los0            DB  	"  ----------------------------- Oh vaya! -----------------------------", EOL     
        flen0           EQU 	$- los0

        los1            DB  	"  ______                       _                _ ", EOL     
        flen1           EQU 	$- los1

    	los2            DB  	" |  ____|                     | |           _  | |", EOL     
        flen2           EQU 	$- los2

    	los3            DB 	    " | |__   _ __ ___  _ __   __ _| |_ ___     (_) | |", EOL     
        flen3           EQU	    $- los3

    	los4            DB  	" |  __| | '_ ` _ \| '_ \ / _` | __/ _ \        | |", EOL     
        flen4           EQU 	$- los4

    	los5            DB  	" | |____| | | | | | |_) | (_| | ||  __/     _  | |", EOL     
        flen5           EQU 	$- los5

    	los6            DB  	" |______|_| |_| |_| .__/ \__,_|\__\___|    (_) |_|", EOL,    
        flen6           EQU 	$- los6

        los7            DB  	"                  | |                             ", EOL,    
        flen7           EQU 	$- los7

    	los8            DB  	"                  |_|                             ", EOL, EOL
        flen8           EQU 	$- los8
    ;

    
    ; -- OPCIONES DEL JUEGO ------------------------------------------------------------------------------
        Gopt1           DB      "Bienvenido, por favor seleccione una opción: ", EOL
        Glen1           EQU	    $- Gopt1

        Gopt2           DB 	    "1. Iniciar juego.", EOL
        Glen2           EQU	    $- Gopt2

        Gopt3           DB 	    "2. Salir.", EOL
        Glen3           EQU	    $- Gopt3

        Gopt4           DB 	    "Opción a escoger: "
        Glen4           EQU	    $- Gopt4
    ;
    
    
    ; -- OPCIONES DEL JUGADORES --------------------------------------------------------------------------
        jugador1        DB      "Jugador 1: X",EOL 
        jugador1_len    EQU     $-jugador1

        jugador2        DB      "Jugador 2: O",EOL 
        jugador2_len    EQU     $-jugador2
    ;

    ; -- OPCIONES DEL TABLERO ----------------------------------------------------------------------------
        tablero         DB '1','2','3',\
                           '4','5','6',\
                           '7','8','9'
        ;
        
        underscore      DB      "_"
        underscore_len  EQU     $-underscore

        pipe            DB      "|"
        pipe_len        EQU     $-pipe
    ;

    ; -- OPCIONES DE LAYOUT ------------------------------------------------------------------------------
        msgCoordenadaY      DB      "Ingrese la coordenada en Y: "
        msgCoordenadaY_len  EQU     $-msgCoordenadaY

        msgCoordenadaX      DB      "Ingrese la coordenada en X: "
        msgCoordenadaX_len  EQU     $-msgCoordenadaX

        cambioLinea         DB      0xA, 0xD
        cambioLinea_len     EQU     $-cambioLinea
    
        simboloX            DB      'X'
        simboloX_len        EQU     $-simboloX

        simboloO            DB      'O'
        simboloO_len        EQU     $-simboloO

        prueba              DB      'sss'
        prueba_len          EQU     $-prueba

        ganarX              DB      'Gano el jugador X'
        ganarX_len          EQU     $-ganarX

        ganarO              DB      'Gano el jugador O'
        ganarO_len          EQU     $-ganarO

        espacioB            DB      ' '
        espacioB_len        EQU     $-espacioB

        errorCoordenada     DB      'Error, dato insertado no es valido',EOL 
        errorCoordenada_len EQU     $-errorCoordenada

        msgEmpate           DB 'Empate',EOL
        msgEmpate_len       EQU $-msgEmpate

        turnoX              DB 'Jugador1: X',EOL 
        turnoX_len          EQU $-turnoX

        turnoO              DB 'Jugador2: O',EOL 
        turnoO_len          EQU $-turnoO

        msgEspacioOcupado   DB 'El espacio ya esta ocupado',EOL 
        msgEspacioOcupado_l DB $-msgEspacioOcupado
    ;
;   

 
section .bss 
    input               RESB    256

    coordenadaX         RESB    1
    coodenadaX_len      EQU     $-coordenadaX

    coordenadaY         RESB    1
    coodenadaY_len      EQU     $-coordenadaY

    opcion              RESB    256
    opcion_len          EQU     $-opcion
;


section .text
global _start
    
_start:

;Objetivo del procedimiento: imprime y pide una opcion del menu
MenuInicio:
    imprimir_bienvenida
    imprimir_opciones
    scanf opcion 

    MOV EAX, opcion
    CMP BYTE[EAX], '1'   ;entra al juego
    JE preparacion
    CMP BYTE[EAX],'2'    ;sale del juego  
    JE exit 

    ;en caso de poner una opcion no valida
    printf errorCoordenada, errorCoordenada_len
    JMP MenuInicio

;Objetivo del procedimiento:empieza los turnos de X y O
preparacion:
    CALL ciclodelJuegoX     ;procesos para que el jugador X haga su movimiento
    CALL ciclodelJuegoO     ;procesos para que el jugador O haga su movimiento
    JMP preparacion         ;repite el proceso de pedir movimientos hasta que alguien haya finalizado de alguna manera la partida

exit:                       ;salir del juego
    MOV     EAX, 1          
    XOR     EBX, EBX
    INT     80H

;hacer el include de los procedimientos del juego
%include 'LogicadelJuego.asm'