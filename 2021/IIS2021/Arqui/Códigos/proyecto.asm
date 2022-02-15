; MACROS
    ; MACROS PARA LLAMAR AL KERNEL

        ; Objetivo del procedimiento: Imprimir en pantalla un valor mediante SYS_WRITE.
        %macro printf 2
            MOV     EAX,     sys_write          ; Opción 4 de las interrupciones del Kernel.
            MOV     EBX,     stdout             ; Standar output.
            MOV     ECX,     %1                 ; Mensaje.
            MOV     EDX,     %2                 ; Longitud.
            INT     0x80
        %endmacro

        ; Objetivo del procedimiento: Capturar información del usurio mediante SYS_READ.
        %macro scanf 0
            MOV     EAX,     sys_read           ; Opción 3 de las interrupciones del Kernel.
            MOV     EBX,     stdin              ; Standar input.
            MOV     ECX,     input              ; Dirección de memoria reservada para almacenar nuestro input (conocido como buffer).
            MOV     EDX,     8                  ; Número de bytes a leer.
            INT     0x80
        %endmacro

        ; Objetivo del procedimiento: Abir un archivo mediante SYS_OPEN.
        %macro open 1
            MOV     EAX,     sys_open          ; Opción 5 de las interrupciones del Kernel.
            MOV     EBX,     %1                ; Archivo por abrir.
            MOV     ECX,     0                 ; 
            INT     0x80
        %endmacro
    ;

    ; MACROS PARA GUARDAR VARIABLES

        ; Objetivo del procedimiento: Guardar la información capturada en el input en una dirección de memoria.
        %macro save_input 1
            MOV     EAX ,    [input]            ; Pasa la información del input a un registro.
            MOV     [%1],    EAX                ; Dirección de memoria donde se almacena el input.
        %endmacro

        ; Objetivo del procedimiento: Guardar la información capturada en el input en una dirección de memoria como entero.
        %macro save_int 1
            MOV     EAX ,    [input]            ; Pasa la información del input a un registro.
            SUB     EAX ,    48                 ; Resta 48 al número. [48 = '0']
            MOV     [%1],    EAX                ; Dirección de memoria donde se almacena el input.
        %endmacro
    ;

    ; MACROS PARA IMPRIMIR MENSAJES

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
            printf  titulo7    ,  ti_len7
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

        ; Objetivo del procedimiento: Imprimir las opciones. [Gopt significa: GAME_option]
        %macro imprimir_opciones 0
            printf  nueva_linea,  nl_len

            printf  Gopt1      ,  Glen1
            printf  nueva_linea,  nl_len
            printf  Gopt2      ,  Glen2
            printf  Gopt3      ,  Glen3

            printf  nueva_linea,  nl_len
            printf  Gopt4      ,  Glen4
        %endmacro

        ; Objetivo del procedimiento: Imprimir las dificultades. [Dopt significa: DICULTY_option]
        %macro imprimir_dificultades 0
            printf  nueva_linea,  nl_len

            printf  Dopt1      ,  DLen1
            printf  Dopt2      ,  DLen2

            printf  nueva_linea,  nl_len

            printf  Dopt3      ,  DLen3
        	printf  Dopt4      ,  DLen4
        	printf  Dopt5      ,  DLen5
            printf  Dopt6      ,  DLen6

            printf  nueva_linea,  nl_len
            printf  Gopt4      , Glen4
        %endmacro

        ; Objetivo del procedimiento: Imprimir el layout del juego cuando el usuario ingresa una letra. [Lopt significa: LAYOUT_option]
        %macro imprimir_layout 2
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  Lopt1       ,  Llen1        ; Titulo del layout 1.
            printf  %1          ,  %2           ; Dificultad actual.
            printf  Lopt2       ,  Llen2        ; Titulo del layout 2.

            printf  Lopt3       ,  Llen3        ; Mensaje de 'Palabra a adivinar:'.
            printf  rayas       ,  rayas_len    ; Mensaje almacenado en la variable 'rayas'.
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

            printf  Lopt4       ,  Llen4        ; Mensaje de 'Letras solicitadas:'.
            printf  buffer      ,  buffer_len   ; Mensaje almacenado en la variable 'buffer'.
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

        	printf  Lopt5       ,  Llen5        ; Mensaje de 'Voy a tener suerte [Teclee 3]:'.
            printf  nueva_linea ,  nl_len       ; Nueva línea
        	
            printf  Lopt6       ,  Llen6        ; Mensaje de 'Turnos disponibles:'.

            CALL validar_digitos_contador       ; Invoca al segmento 'validar_digitos_contador'.

            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

            printf  Lopt7       ,  Llen7        ; Mensaje de 'Presione la tecla ESC para salir.'.
            printf  nueva_linea ,  nl_len       ; Nueva línea.
        %endmacro

        ; Objetivo del procedimiento: Imprimir el layout del juego CUANDO EL USUARIO GANÓ adivinando LETRA A LETRA.
        %macro imprimir_layout_final 2
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  Lopt1       ,  Llen1        ; Titulo del layout 1.
            printf  %1          ,  %2           ; Dificultad actual.
            printf  Lopt2       ,  Llen2        ; Titulo del layout 2.
            

            printf  msgPalabra  ,  msgPlen      ; Mensaje de 'La palabra correcta es:'.
            printf  palabra     ,  palabra_len  ; Mensaje almacenado en la variable 'palabra'.

            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

            printf  msgUsted    ,  msgUlen      ; Mensaje de 'Usted escribió: '.
            printf  rayas       ,  rayas_len    ; Mensaje almacenado en la variable 'rayas'.

            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

            printf  Lopt4       ,  Llen4        ; Mensaje de 'Letras solicitadas:'.
            printf  buffer      ,  buffer_len   ; Mensaje almacenado en la variable 'buffer'.

            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

            printf  Lopt6       ,  Llen6        ; Mensaje de 'Turnos disponibles:'.

            CALL validar_digitos_contador       ; Invoca al segmento 'validar_digitos_contador'.

            printf  nueva_linea ,  nl_len       ; Nueva línea.
        %endmacro

        ; Objetivo del procedimiento: Imprimir el layout del juego CUANDO EL USUARIO GANÓ adivinando TODA LA PALABRA.
        %macro imprimir_layout_adivino 2
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  Lopt1       ,  Llen1        ; Titulo del layout 1.
            printf  %1          ,  %2           ; Dificultad actual.
            printf  Lopt2       ,  Llen2        ; Titulo del layout 2.
            
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            
            printf  msgPalabra  ,  msgPlen      ; Mensaje de 'La palabra correcta es:'.
            printf  palabra     ,  palabra_len  ; Mensaje almacenado en la variable 'palabra'.
            
            printf  nueva_linea ,  nl_len       ; Nueva línea.
            printf  nueva_linea ,  nl_len       ; Nueva línea.

            printf  msgUsted    ,  msgUlen      ; Mensaje de 'Usted escribió: '.
            printf  rayas       , rayas_len     ; Mensaje almacenado en la variable 'rayas'.
            
            printf  nueva_linea ,  nl_len       ; Nueva línea.
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

    ; -- ARCHIVOS DE LAS DIFICULTADES -------------------------------------------------------------------- 
        filename1       DB      'baja.txt' , 0
        filename2       DB      'media.txt', 0
        filename3       DB      'alta.txt' , 0
    ;

    ; -- OTRAS VARIABLES ---------------------------------------------------------------------------------
        nueva_linea     DB 	    10, 13 
        nl_len          EQU	    $- nueva_linea
        EOL             EQU 	10

        buffer          DB      "              "
        buffer_len      EQU     $- buffer
    ;

    ; -- NOMBRE DEL JUEGO --------------------------------------------------------------------------------
        titulo0         DB 	    "  ---------------------- BIENVENIDO AL JUEGO -'---------------------- ", EOL
        ti_len0         EQU     $- titulo0

        titulo1         DB  	"           _                             _                            ", EOL     
        ti_len1         EQU 	$- titulo1                                                                          

    	titulo2         DB  	"     /\   | |                           | |         /               \ ", EOL     
        ti_len2         EQU 	$- titulo2                                                                          

    	titulo3         DB 	    "    /  \  | |__   ___  _ __ ___ __ _  __| | ___    |  __  __ __  __  |", EOL     
        ti_len3         EQU	    $- titulo3                                                                          

    	titulo4         DB  	"   / /\ \ | '_ \ / _ \| '__/ __/ _` |/ _` |/ _ \   |  \ \/ / \ \/ /  |", EOL     
        ti_len4         EQU 	$- titulo4                                                                          

    	titulo5         DB  	"  / ____ \| | | | (_) | | | (_| (_| | (_| | (_) |  |   >  < _ >  <   |", EOL     
        ti_len5         EQU 	$- titulo5                                                                          

    	titulo6         DB  	" /_/    \_\_| |_|\___/|_|  \___\__,_|\__,_|\___/   |  /_/\_(_)_/\_\  |", EOL,    
        ti_len6         EQU 	$- titulo6                                                                          

    	titulo7         DB  	"                                                    \               / ", EOL, EOL
        ti_len7         EQU 	$- titulo7
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

	; -- OPCIONES DEL JUEGO ------------------------------------------------------------------------------
        Gopt1           DB 	    "   Bienvenido, por favor seleccione una opción: ", EOL
        Glen1           EQU	    $- Gopt1

        Gopt2           DB 	    "	1. Iniciar juego.", EOL
        Glen2           EQU	    $- Gopt2

    	Gopt3           DB 	    "	2. Salir.", EOL
        Glen3           EQU	    $- Gopt3

    	Gopt4           DB 	    "   Opción a escoger: "
        Glen4           EQU	    $- Gopt4
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
        los0            DB  	"  ----------------------------- Oh no! -----------------------------", EOL     
        flen0           EQU 	$- los0

        los1            DB  	"     ______                     _         _           _        __", EOL     
        flen1           EQU 	$- los1

    	los2            DB  	"    |  ____|                   | |       | |         | |    _ / /", EOL     
        flen2           EQU 	$- los2

    	los3            DB 	    "    | |__      ___ _ __     ___| |    ___| |__   __ _| |_  (_) | ", EOL     
        flen3           EQU	    $- los3

    	los4            DB  	"    |  __|    / _ \ '_ \   / _ \ |   / __| '_ \ / _` | __|   | | ", EOL     
        flen4           EQU 	$- los4

    	los5            DB  	"    | |      |  __/ | | | |  __/ |  | (__| | | | (_| | |_   _| | ", EOL     
        flen5           EQU 	$- los5

    	los6            DB  	"    |_|       \___|_| |_|  \___|_|   \___|_| |_|\__,_|\__| (_) | ", EOL,    
        flen6           EQU 	$- los6

    	los7            DB  	"                                                              \_\", EOL, EOL
        flen7           EQU 	$- los7
    ;

	; -- OPCIONES DE DIFICULTAD --------------------------------------------------------------------------
        Dopt1           DB  	"  ----------------- MENÚ PRINCIPAL : INCIAR JUEGO ------------------", EOL, EOL
        DLen1           EQU 	$- Dopt1

        Dopt2           DB  	"   Seleccione la dificultad: ", EOL
        DLen2           EQU 	$- Dopt2

        Dopt3           DB 	    "	1. Bajo.", EOL
        DLen3           EQU	    $- Dopt3

	    Dopt4           DB 	    "	2. Medio.", EOL
        DLen4           EQU	    $- Dopt4

    	Dopt5           DB  	"	3. Alto.", EOL
        DLen5           EQU 	$- Dopt5

	    Dopt6           DB  	"	4. Regresar al menú anterior.", EOL
        DLen6           EQU 	$- Dopt6
    ;

    ; -- OPCIONES DE LAYOUT ------------------------------------------------------------------------------
        
        ; DIFICULTADES
            dif_baja    DB 	    "BAJA"
            baja_len    EQU	    $- dif_baja

            dif_media   DB 	    "MEDIA"
            media_len   EQU	    $- dif_media

            dif_alta    DB 	    "ALTA"
            alta_len    EQU	    $- dif_alta
        ;

        Lopt1           DB  	"  -------------- JUEGO DE AHORCADO : DIFICULTAD["
        Llen1           EQU 	$- Lopt1

        Lopt2           DB  	"] --------------", EOL, EOL
        Llen2           EQU 	$- Lopt2
        
        Lopt3           DB  	"   Palabra a adivinar:  "
        Llen3           EQU 	$- Lopt3

        Lopt4           DB  	"   Letras solicitadas:  "
        Llen4           EQU 	$- Lopt4

    	Lopt5           DB 	    "   Voy a tener suerte [Teclee 3]: ", EOL
        Llen5           EQU	    $- Lopt5

    	Lopt6           DB 	    "   Turnos disponibles: "
        Llen6           EQU	    $- Lopt6

    	Lopt7           DB  	"   Presione la tecla ESC para salir.", EOL
        Llen7           EQU 	$- Lopt7

        Lopt8           DB  	"   Inserte una letra: "
        Llen8           EQU 	$- Lopt8

        Llopt9          DB      "   Digite la palabra entera: "
        Llopt9_len      EQU     $- Llopt9

        msgPalabra      DB      "   La palabra correcta es: "
        msgPlen         EQU     $- msgPalabra

        msgUsted        DB      "   Usted escribió: "
        msgUlen         EQU     $- msgUsted
    ;
;


section .bss
    ; VARIABLES PARA EL MENU.
        input:          RESD    1               ; Variable para almacenar el input del usuario.
        input_len       EQU     $- input        ; Longitud de la variable "input".

        option:         RESD    1               ; Variable para almacenar la opción elegida del usuario.
        option_len      EQU     $- option       ; Longitud de la variable "option".
        
        dificultad      RESD    1               ; Variable para almacenar la dificultad escogida.
        dificultad_len  EQU     $- dificultad   ; Longitud de la variable "dificultad".
    ;

    ; VARIABLES PARA ARCHIVOS.
        fileContents    RESB    255             ; Variable para almacenar el contenido de un archivo.
        file_len        EQU     $- fileContents ; Longitud de la variable "fileContents".

        palabra         RESB    255             ; Variable para almacenar la palabra seleccionada del archivo.
        palabra_len     EQU     $- palabra      ; Longitud de la variable "palabra".

        rayas           RESB    255             ; Variable para almacenar las letras de los inputs.
        rayas_len       EQU     $- rayas        ; Longitud de la variable "letras".
    
        completa        RESB    255             ; Variable para almacenar la palabra completa cuando el usuario tecelea 3.
        completa_len    EQU     $- completa     ; Longitud de la variable "letras".

        contador        RESB    255             ; Variable para almacenar el contador.
        contador_len    EQU     $- contador     ; Longitud de la variable "contador".

        decenas:        RESB    255             ; Variable para almacenar las decenas.
        decenas_len     EQU     $- decenas      ; Longitud de la variable "decenas".

        unidades:       RESB    255             ; Variable para almacenar las unidades.
        unidades_len    EQU     $- unidades     ; Longitud de la variable "unidades".
    ;
;


section .text
   global _start                                ; Inicio del programa.
;


; Objetivo del procedimiento: Despliega la información y captura si el usuario quiere jugar o salir.
_start:
	; IMPRIMIR MENSAJE INICIAL.
        imprimir_bienvenida
	    imprimir_opciones
    ;

    ; CAPTURAR OPCIÓN DE USUARIO.
	    scanf                                   ; Captura una entrada.
	    save_input  input                       ; Lo guarda en la variable 'input'.

	    CMP 	AL  ,  '1'                      ; Lo comparara con 1 :
	    JLE 	menu_principal                  ;   - Si entrada <= 1 : pasa al segmento 'menu_principal'.
	    JG 		exit                            ;   - Si entrada >  1 : pasa al segmento 'exit'.
    ;
;


; Objetivo del procedimiento: Despliega la información y captura la dificultad deseada.
menu_principal:
    ; IMPRIMIR
        imprimir_dificultades
    ;

    ; CAPTURAR OPCIÓN DE USUARIO.
	    scanf                                   ; Captura un input.
        save_int    dificultad                  ; Lo guarda como un int en la variable 'dificultad'.
	    save_input  option                      ; Lo guarda en la variable 'option'.

        CMP     AL  ,  '4'                      ; Lo comparara con 4:
        JGE     _start                          ;   - Si entrada >= 4 : pasa al segmento '_start'.

	    CMP 	AL  ,  '2'                      ; Lo comparara con 2:
	    JL 	    baja                            ;   - Si entrada < 2 : pasa al segmento 'baja'.
        JE      media                           ;   - Si entrada = 2 : pasa al segmento 'media'.
	    JG 		alta                            ;   - Si entrada > 2 : pasa al segmento 'alta'.
    ;

    ; Objetivo del procedimiento: Asignar la cantidad de turnos correspondientes y abrir el archivo de palabras correspondientes a la dificultad.
    baja:
        MOV     EDX       , 9                   ; Asigna la cantidad de turnos de la dificultad baja.
        MOV 	[contador], EDX                 ; Lo mueve a la variable 'contador'.

        open    filename1                       ; Abre el archivo de dificultad baja.
        JMP     juego                           ; Pasa al segmento 'juego'.
    ;


    ; Objetivo del procedimiento: Asignar la cantidad de turnos correspondientes y abrir el archivo de palabras correspondientes a la dificultad.
    media:
        MOV     EDX       , 12                  ; Asigna la cantidad de turnos de la
        MOV 	[contador], EDX                 ; Lo mueve a la variable 'contador'.

        open    filename2                       ; Abre el archivo de dificultad media.
        JMP     juego                           ; Pasa al segmento 'juego'.
    ;


    ; Objetivo del procedimiento: Asignar la cantidad de turnos correspondientes y abrir el archivo de palabras correspondientes a la dificultad.
    alta:
        MOV     EDX       , 14                  ; Asigna la cantidad de turnos de la
        MOV 	[contador], EDX                 ; Lo mueve a la variable 'contador'.

        open    filename3                       ; Abre el archivo de dificultad alta.
        JMP     juego                           ; Pasa al segmento 'juego'.
    ;
;


; Objetivo del procedimiento: Es el juego.
juego:
    ; LEER ARCHIVO
        MOV     EDX,  128                       ; Numero de bytes a leer (uno por cada caracter).
        MOV     ECX,  fileContents              ; Variable donde se almacena la información.
        MOV     EBX,  EAX                       ; Mueve el archivo abierto a EBX.
        MOV     EAX,  sys_read                  ; Invoca a SYS_READ (opción 3 de las interrupciones del Kernel).
        INT     0x80
    ;

    ; CERRAR ARCHIVO
        MOV     EBX,  EBX                       ; No es necesario, pero se usa para demostrar que SYS_clOSE toma un descriptor de archivo de EBX.
        MOV     EAX,  sys_close                 ; Invoca a SYS_clOSE (opción 6 de las interrupciones del Kernel).
        INT     80h
    ;

    ; OBTENER PALARABA Y PALABRA RAYA
    
        ; Objetivo del procedimiento: Generar la posicion alatorea para seleccionar una palabra de un archivo texto.
        generar_random:
            XOR     EAX,  EAX                   ; Se limpia el registro.
            XOR     EBX,  EBX                   ; Se limpia el registro.
            XOR     ECX,  ECX                   ; Se limpia el registro.
            XOR     EDX,  EDX                   ; Se limpia el registro.
            RDTSC                               ; Read Time Stamp Counter.
            AND     EAX,  0x00000007            ; Después de generar un random, le pone un límite en 7.

            CMP     EAX,  0                     ; Compara el random con 0:
            JE      generar_random              ;   - Si random = 0 : pasa al segmento 'generar_random'.

            MOV     ECX,  EAX                   ; Coloca el numero que representa la posicion de la palabra seleccionada en ECX.
            MOV     EAX,  fileContents          ; Pasa el contenido del archivo a EAX.
            MOV     EBX,  palabra               ; Coloca en EBX la dirección de memoria para almacenar la palabra.
            MOV     EDX,  1                     ; Llevar la cuenta de las palabras que se han recorrido
        ;

        ; Objetivo del procedimiento: Recorrer el archivo hasta encontrar la palabra deseada.
        recorrer_archivo:
            MOV     ESI,0                       ;llevar cuenta de la cantidad de letras real
            CMP     ECX,  EDX                   ; Compara el número de la posición buscada (ECX), con la posición actual (EDX).
            JE      leer_palabra                ;   - Si [ECX] = [EDX]: Se coincidencia la posición correcta y se pasa a leer la palabra.
            
            CMP     BYTE[EAX],  ','             ; Compara el byte actual de EAX con una coma.
            JNE     siguiente_caracter          ;   - Si el byte no es igual : Pasa al segmento 'siguiente_caracter'.
            JE      siguente_palabra            ;   - Si el byte es igual    : Pasa al segmento 'siguente_palabra'.
        ;
        
        ; Objetivo del procedimiento: Incrementar el registro EAX para recorrer caracter a caracter.
        siguiente_caracter:
            INC     EAX                         ; Continúa con el siguiente caracter del archivo.
            JMP     recorrer_archivo            ; Se devuelve a recorrer el archivo.
        ;

        ; Objetivo del procedimiento: Incrementar el registro EAX para recorrer caracter a caracter y EDX para sumar 1 al contador de palabras.
        siguente_palabra:
            INC     EDX                         ; Aumenta el contador de palabra.
            INC     EAX                         ; Continúa con el siguiente caracter del archivo.
            JMP     recorrer_archivo            ; Se devuelve a recorrer el archivo.
        ;
        
        ; Objetivo del procedimiento: Una vez encontrada la posicion forma la palabra comparanto bit a bit.
        leer_palabra:
            CMP     BYTE[EAX],  ','             ; Compara el byte actual de EAX con una coma.
            JE      contarPalabraNueva          ;   - Si el byte es igual: Pasa al segmento 'apuntar_palabra'.

            MOV     CL,  BYTE[EAX]              ; Pasa al registro CL el caracter del byte de EAX.
            MOV     BYTE[EBX],  CL              ; Pasa al byte del caracter EBX (dirección de memoria de la palabra) el caracter que qeudó en CL.

            INC     EAX                         ; Incrementa el registro.
            INC     EBX   
            INC     ESI                         ; Incrementa el registro.
            JMP     leer_palabra                ; Repite el ciclo hasta que encuentre una coma.
        ;

        ;Objetivo:si se esta sustituyendo la palabra, cambia los espacios para que no afecte la nueva palabra
        contarPalabraNueva:
                CMP ESI, 255
                JE apuntar_palabra
                MOV byte[ebx],0         ;sustituir lo restante de los 255 con 0
                INC EBX
                INC ESI 
                JMP contarPalabraNueva
        
        ; Objetivo del procedimiento: Prepara los registros para recorrer la palabra.
        apuntar_palabra:
            MOV     EBX,  palabra               ; Mueve la dirección de nuestra palabra a EBX.
            MOV     EAX,  EBX                   ; Mueve la dirección en EBX a EAX también (Ambos ahora apuntan al mismo segmento en la memoria).
            MOV     ECX,  1                     ; ECX va a contener la longitud de la palabra.
        ;

        ; Objetivo del procedimiento: Compara el byte apuntado por EAX en esta dirección con cero (delimitador de final de palabra).
        recorrer_palabra:
            CMP     BYTE[EAX], 0
            JZ      apuntar_rayas               ;   - Si el byte es igual: Pasa al segmento 'apuntar_rayas'.

            INC     EAX                         ; Incrementa la dirección en EAX en un byte.
            INC     ECX                         ; Incrementa la dirección en ECX en un byte.
            JMP     recorrer_palabra            ; Repite el ciclo hasta que encuentre un 0.
        ;
        
        ; Objetivo del procedimiento: Prepara los registros para recorrer las rayas.
        apuntar_rayas:   
            MOV     EBX,  rayas                 ; Mueve la dirección de nuestra Palabra raya a EBX.
            MOV     EAX,  EBX                   ; Mueve la dirección en EBX a EAX también (Ambos ahora apuntan al mismo segmento en la memoria).
            mov     ESI,0                       ; llevar cuenta de la cantidad de letras real
        ;


        ; Objetivo del procedimiento: Prepara los registros para recorrer las rayas.
        formar_rayas:                           ; Rellenar la dirección 'rayas' con lineas y espacios.
            DEC     ECX                         ; Decrementa la dirección en ECX en un byte.
            
            CMP     ECX,  0                     ; Compara el byte apuntado por ECX en esta dirección con cero.
            JZ      contarPalabraNuevaR

            MOV     BYTE[EAX], '_'              ; Mueve "_" al byte correspondiente.
            INC     EAX                         ; Incrementa el registro.
            
            MOV     BYTE[EAX], ' '              ; Mueve " " al byte correspondiente.
            INC     EAX   
            INC     ESI                         ; Incrementa el registro.
            JMP     formar_rayas                ; Repite el ciclo hasta que encuentre un 0.
        ;
        ;Objetivo:si se esta sustituyendo la palabra, cambia los espacios para que no afecte laa nueva palabra
        contarPalabraNuevaR:
            CMP ESI, 255        ;255 declarados en el segmento .bss
            JE  validar_turno
            MOV byte[eax],0     ;sustituir lo restante de los 255 con 0
            INC eax
            INC esi 
            JMP contarPalabraNuevaR
    ;

    ; IMPRIMIR LAYOUT DEL JUEGO

        
        ; Objetivo del procedimiento: Validar que sea posible jugar (que el contador no esté en 0).
        validar_turno:
            MOV     EAX, [contador]             ; Paso a EAX mi contador actual.

            CMP     AL , 0                      ; Compara con 0 para ver si no se acabaron los turnos
            JNZ     validar_dificultad
            JZ      validar_dificultad3
        ;

        ; Objetivo del procedimiento: Valida la dificultad.
        validar_dificultad:
            MOV     EAX, [dificultad]           ; Mueve a un registro la dificultad del juego.
            CMP     AL , 2                      ; Lo comparara con 2:
            JL      imprimir_baja               ;   - Si dificultad < 2 : pasa al segmento 'baja'.
            JE      imprimir_media              ;   - Si dificultad = 2 : pasa al segmento 'media'.
            JG      imprimir_alta               ;   - Si dificultad > 2 : pasa al segmento 'alta'.
        ;

        ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente.
        imprimir_baja:
            imprimir_layout dif_baja, baja_len  ; Imprime el layout.
            printf  Lopt8, Llen8                ; Imprime opción de insertar.
            JMP capturar_input                  ; Captura el input.
        ;

        ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente.
        imprimir_media:
            imprimir_layout dif_media, media_len; Imprime el layout.
            printf  Lopt8, Llen8                ; Imprime opción de insertar.
            JMP capturar_input                  ; Captura el input.
        ;

        ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente.
        imprimir_alta:
            imprimir_layout dif_alta, alta_len  ; Imprime el layout.
            printf  Lopt8, Llen8                ; Imprime opción de insertar.
            JMP capturar_input                  ; Captura el input.
        ;

        ; IMPRIMIR LAYOUT FINAL
            ; EL JUGADOR GANÓ
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA GANÓ.
                validar_dificultad2:
                    MOV     EAX, [dificultad]   ; Mueve a un registro la dificultad del juego.
                    CMP     AL , 2              ; Lo comparara con 2:
                    JL      imprimir_baja2      ;   - Si dificultad < 2 : pasa al segmento 'baja'.
                    JE      imprimir_media2     ;   - Si dificultad = 2 : pasa al segmento 'media'.
                    JG      imprimir_alta2      ;   - Si dificultad > 2 : pasa al segmento 'alta'.
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA GANÓ.
                imprimir_baja2:
                    imprimir_layout_final dif_baja, baja_len
                    imprimir_gane
                    JMP exit
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA GANÓ.
                imprimir_media2:
                    imprimir_layout_final dif_media, media_len
                    imprimir_gane
                    JMP exit
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA GANÓ.
                imprimir_alta2:
                    imprimir_layout_final dif_alta, alta_len
                    imprimir_gane
                    JMP exit
                ;
            ;

            ; EL JUGADOR PERDIÓ
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA PERDIÓ.
                validar_dificultad3:
                    MOV     EAX, [dificultad]       ; Mueve a un registro la dificultad del juego.
                    CMP     AL , 2                  ; Lo comparara con 2:
                    JL      imprimir_baja3          ;   - Si dificultad < 2 : pasa al segmento 'baja'.
                    JE      imprimir_media3         ;   - Si dificultad = 2 : pasa al segmento 'media'.
                    JG      imprimir_alta3          ;   - Si dificultad > 2 : pasa al segmento 'alta'.
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA PERDIÓ.
                imprimir_baja3:
                    imprimir_layout_final dif_baja, baja_len
                    imprimir_pierde
                    JMP exit
                ;
                
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA PERDIÓ.
                imprimir_media3:
                    imprimir_layout_final dif_media, media_len
                    imprimir_pierde
                    JMP exit
                ;
                
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR YA PERDIÓ.
                imprimir_alta3:
                    imprimir_layout_final dif_alta, alta_len
                    imprimir_pierde
                    JMP exit
                ;
            ;

            ; EL JUGADOR ADIVINÓ
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR ADIVINA Y GANA.
                validar_dificultad4:
                    MOV     EAX, [dificultad]       ; Mueve a un registro la dificultad del juego.
                    CMP     AL , 2                  ; Lo comparara con 2:
                    JL      imprimir_baja4          ;   - Si dificultad < 2 : pasa al segmento 'baja'.
                    JE      imprimir_media4         ;   - Si dificultad = 2 : pasa al segmento 'media'.
                    JG      imprimir_alta4          ;   - Si dificultad > 2 : pasa al segmento 'alta'.
                ;
                
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR ADIVINA Y GANA.
                imprimir_baja4:
                    imprimir_layout_adivino dif_baja, baja_len
                    imprimir_gane
                    JMP exit
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR ADIVINA Y GANA.
                imprimir_media4:
                    imprimir_layout_adivino dif_media, media_len
                    imprimir_gane
                    JMP exit
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR ADIVINA Y GANA.
                imprimir_alta4:
                    imprimir_layout_adivino dif_alta, alta_len
                    imprimir_gane
                    JMP exit
                ;
            ;

            ; EL JUGADOR NO ADIVINÓ
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR NO ADIVINA Y PIERDE.
                validar_dificultad5:
                    MOV     EAX, [dificultad]       ; Mueve a un registro la dificultad del juego.
                    CMP     AL , 2                  ; Lo comparara con 2:
                    JL      imprimir_baja5          ;   - Si dificultad < 2 : pasa al segmento 'baja'.
                    JE      imprimir_media5         ;   - Si dificultad = 2 : pasa al segmento 'media'.
                    JG      imprimir_alta5          ;   - Si dificultad > 2 : pasa al segmento 'alta'.
                ;
                
                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR NO ADIVINA Y PIERDE.
                imprimir_baja5:
                    imprimir_layout_adivino dif_baja, baja_len
                    imprimir_pierde
                    JMP exit
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR NO ADIVINA Y PIERDE.
                imprimir_media5:
                    imprimir_layout_adivino dif_media, media_len
                    imprimir_pierde
                    JMP exit
                ;

                ; Objetivo del procedimiento: Imprime el layout de la dificultad correspondiente CUANDO EL JUGADOR NO ADIVINA Y PIERDE.
                imprimir_alta5:
                    imprimir_layout_adivino dif_alta, alta_len
                    imprimir_pierde
                    JMP exit
                ;
            ;
        ;
    ;

    ; RESTAR 1 AL CONTADOR
        ; Objetivo del procedimiento: Validar si el número tiene más de 1 dígito.
        validar_digitos_contador:
            XOR     EAX,  EAX
            XOR     EBX,  EBX
            XOR     ECX,  ECX
            XOR     EDX,  EDX

            ; VALIDO: CONTADOR > 9
            MOV     EAX, [contador]             ; Paso a EAX mi contador actual.
            CMP     AL , 9                      ; Compara con 9 para ver la cantidad de decenas existentes.
            JG      calcular_dos_digitos
            
            ; LO IMPRIMO
            ADD     EAX       , 48              ; Suma 48 para imprimirlo
            MOV     [contador], EAX             ; Pasa el resultado a la variable
            printf  contador, contador_len


            ; RESTO 1
            MOV     EAX, [contador]             ; Paso a EAX mi contador actual.
            SUB     EAX       , 48              ; Resta 48 al contador para operar con el como entero.
            SUB     EAX       , 1               ; Resta 1 al contador.
            MOV     [contador], EAX             ; Pasa el resultado a la variable
            RET
        ;
        
        ; Objetivo del procedimiento: Separa el contador en decenas y unidades.
        calcular_dos_digitos:
            MOV     EAX       , [contador]      ; Paso a EAX mi contador actual.

            ; CALCULO DECENAS.
            MOV     ECX       ,   10            ; Pongo un 10 en ECX.
            DIV     ECX                         ; Realizo la división.
            ADD     EAX       ,   48            ; Sumo 48 al registro para imprimir las decenas.
            MOV     [decenas] ,   EAX           ; Almaceno en 'decenas' el resultado que está en EAX.
            SUB     EAX       ,   48            ; Resta 48 al contador para operar con el como entero.

            ; CALCULO UNIDADES.
            MOV     EBX       ,   10            ; Pongo un 10 en EBX.
            MUL     EBX                         ; Multiplico.
            MOV     EDX       ,   EAX           ; Muevo ese resultado a EDX.

            MOV     EAX       ,   [contador]    ; Muevo resultado a EAX.
            SUB     EAX       ,   EDX           ; Resto EDX a EAX.
            ADD     EAX       ,   48            ; Sumo 48 al registro para imprimir las unidades.
            MOV     [unidades],   EAX           ; Almaceno en 'unidades' el resultado que está en EAX.

            ; IMPRIMIR EL NÚMERO
            printf decenas , decenas_len        ; Imprimo las decenas.
            printf unidades, unidades_len       ; Imprimo las unidades.

            ; RESTO 1 AL CONTADOR
            MOV     EAX       , [contador]      ; Paso a EAX mi contador actual.
            SUB     EAX       , 1               ; Resta 1 al contador.
            MOV     [contador], EAX             ; Pasa el resultado a la variable
            RET
        ;
    ;

    ; CAPTURAR INPUT DE USUARIO
        ; Objetivo del procedimiento: Obtener el input y valida según las distintas opciones.
        capturar_input:
            scanf                               ; Captura un input.
            save_input option                   ; Lo guarda como un int en la variable 'option'.

            CMP     AL,  27                     ; Compara la entrada con 27:
            JE      volver_al_menu              ;   - Si es igual: Brinca a 'volver_al_menu'.
            
            CMP     AL,  51                     ; Compara la entrada con 3.
            JE      capturar_palabra_completa   ;   - Si es igual brinca a 'capturar_palabra_completa'.

            MOV     EAX,  palabra               ; Mueve la dirección a EAX la palabra.
            MOV     EBX,  rayas                 ; Coloca en EBX queda la palabra con los espacios en blanco.

            MOV     CL ,  BYTE[option]          ; Paso el input a registro de 8 bits.
            CALL    agregar_letra_buffer
            JMP     validar_palabra             ; Brinca a 'validar_palabra'.
        ;

        ; Objetivo del procedimiento: Capturar la palabra completa del usuario. (Cuando teclea 3)
        capturar_palabra_completa:
            printf nueva_linea, nl_len
            printf Llopt9, Llopt9_len
            
            MOV     EDX,  completa_len          ; Salida de linux.
            MOV     ECX,  completa              ; Muevo el input a ECX.
            MOV     EBX,  stdin                 ; Preparo el out.
            MOV     EAX,  sys_read              ; Opción de sys_read.
            INT     0x80                        ; Kernel linux.

            CALL    apuntar_palabra_completa
            MOV     EAX,  rayas                 ; Palabra que a inicio estaba con espacios en blanco.
            MOV     ECX,  palabra               ; Contenido del archivo.
            JMP     validar_palabra_completa
        ;

        ; Objetivo del procedimiento: 
        apuntar_palabra_completa:
            MOV     EAX,  completa              ; Mueve la dirección a EAX, el input de la palabra.
            MOV     ECX,  rayas                 ; Coloca en EBX queda la palabra con los espacios en blanco.
        ;

        ; Objetivo del procedimiento: Se cambia espacios en blanco por la palabra que ingreso el usuario.
        agregar_letras:
            MOV     DL       ,  BYTE[EAX]       ; Mueve a DL el byte de la palabra.
            MOV     BYTE[ECX],  DL              ; Realizar el cambio de letra.
            CMP     BYTE[EAX],  0               ; Valida si terminó de recorer la palabra.
            JE      retornar_palabra_completa

            INC     ECX                         ; Incrementa el registro.
            INC     ECX                         ; Incrementa el registro.
            INC     EAX                         ; Incrementa el registro.

            JMP     agregar_letras
        ;
        
        ; Objetivo del procedimiento: Retorna la palabra.
        retornar_palabra_completa:
            RET
        ;

        ; Objetivo del procedimiento: Valida que la palabra insertada es correcta.
        validar_palabra_completa:
            MOV     DL       ,  BYTE[EAX]       ; Mueve a DL el byte de la palabra insertada.
            CMP     BYTE[ECX],  0               ; Valida si terminó de recorer la palabra.
            JE      validar_dificultad4

            CMP     BYTE[ECX],  DL              ; Si corresponde a la palabra
            JNE     validar_dificultad5
            
            INC     ECX
            INC     EAX
            INC     EAX
            JMP     validar_palabra_completa
        ;

        ; Objetivo del procedimiento: Limpiar variables y retorna al menú principal
        volver_al_menu:                         ; Se presiona ESC.
            CALL    limpiar_buffer

            XOR     EAX      , EAX              ; Limpia el registro.
            MOV     [palabra], EAX              ; Mueve el registro a la palabra.

            JMP     menu_principal              ; Brinca al menú principal.
        ;
    ;
    
    ; RELLENAR BUFFER.
        
        ; Objetivo del procedimiento: Agregar a las letras utilizadas.
        agregar_letra_buffer:
            PUSH     RDX                        ; PUSH a la pila del registro que se va autilizar para guardar la letra.
            MOV      EDX,  buffer
        ;
        
        ; Objetivo del procedimiento: Recorrer hasta encontrar donde poner la letra.
        insertar_letra: 
            CMP     BYTE[EDX],  ' '
            JNE     incrementar_letra
            JE      agregar_al_buffer
        ;

        ; Objetivo del procedimiento: Recorrer hasta encontrar donde poner la letra.
        incrementar_letra:
            INC     EDX
            JMP     insertar_letra
        ;

        ; Objetivo del procedimiento: Mover la letra a buffer.
        agregar_al_buffer:
            MOV     BYTE[EDX],  CL
            POP     RDX                         ; Pop a la pila para continuar el proceso con el registro.
            RET
        ;
    ;

    ; VACIAR EL BUFFER.
        ; Objetivo del procedimiento: Mover al buffer a EAX.
        limpiar_buffer:
            MOV     EAX     , buffer
        ;

        ; Objetivo del procedimiento: Si encuentra un valor diferente a '_', lo sustituye.
        cambiar_letra:
            CMP     BYTE[EAX], '_'
            JNE     sustituir_letra
            JE      terminar_sustituir_letra
        ;
        
        ; Objetivo del procedimiento: Cambiar la letra que estaba guardada por '_'.
        sustituir_letra:
            MOV     BYTE[EAX], ' '
            INC     EAX
            JMP     cambiar_letra
        ;

        ; Objetivo del procedimiento: Retrona la palabra.
        terminar_sustituir_letra:
            RET
        ;
    ;

    ; VALIDAR PALABRA
        ; Objetivo del procedimiento: Recorre la palabra correcta confomre a los inputs del usuario.
        validar_palabra:
            CMP     BYTE[EAX],  CL              ; Valida si la letra del input esta en la palabra.
            JE      coincidencia                ;   - Si la encuentra: Brinca a 'coincidencia'
            
            CMP     BYTE[EAX], 0                ; Compara el byte apuntado por EAX en esta dirección con cero (delimitador de final de palabra).
            JE      preparar_revision           ;   - Si el byte es igual: Pasa al segmento 'preparar_revision'.

            INC     EAX                         ; Incrementa el registro.
            INC     EBX                         ; Incrementa el registro.
            INC     EBX                         ; Incrementa el registro.
            JMP     validar_palabra             ; Repite el cilco hasta terminar de recorrer la palabra.
        ;

        ; Objetivo del procedimiento: Cuando encuentra coincidencia realiza el cambio correspondiente.
        coincidencia:
            MOV     BYTE[EBX], CL               ; Hace el cambio de la letra con los espacio en blanco.

            INC     EBX                         ; Coloca la letra en lugar del '_'.
            INC     EBX                         ; Avanza en 2 por el espacio en blanco.
            INC     EAX                         ; Avanza en la palabra.
            JMP     validar_palabra             ; Vuelve a 'validar_palabra' hasta terminar de recorrer la palabra.
        ;

        ; Objetivo del procedimiento: Prepara los registros para validar el gane.
        preparar_revision:                      ; Mueve las palabras obtenidas.
            MOV     EAX,  rayas                 ; Palabra que a inicio estaba con espacios en blanco.
            MOV     ECX,  palabra               ; Contenido del archivo.
        ;     
    ;

    ; VALIDAR GANE
        ; Objetivo del procedimiento: Recorre la palabra y valida si es coincide lo ingresado.
        verificar_gane:
            MOV     DL       ,   BYTE[EAX]      ; Mueve a DL el BYTE actual en EAX.

            CMP     BYTE[ECX],  DL              ; Compara el byte actual de ECX con DL.
            JNE     validar_turno               ;   - Si no es igual brinca a 'validar_dificultad' para imprimir el layout de pérdida.

            CMP     BYTE[ECX], 0                ; Compara el byte actual de ECX con 0 para verificar si terminó.
            JE      jugador_gano                ;   - Si es igual brinca a 'jugador_gano' para imprimir el layout de gane. 

            INC     ECX                         ; Incrementa el registro.
            INC     EAX                         ; Incrementa el registro.
            INC     EAX                         ; Incrementa el registro.
            JMP     verificar_gane              ; Repite el ciclo hasta que gane o pierda.
        ;

        ; Objetivo del procedimiento: Brincar a otro segmento que valide la dificultad e imprima un layout en base a eso.
        jugador_gano:
            JMP validar_dificultad2             ; Brinca a 'validar_dificultad' para imprimir el layout. 
        ;
        
        ; Objetivo del procedimiento: Brincar a otro segmento que valide la dificultad e imprima un layout en base a eso.
        jugador_adivino:
            JMP validar_dificultad4             ; Brinca a 'validar_dificultad' para imprimir el layout. 
        ;
    ;
;    


; Objetivo del procedimiento: Salir del programa.
exit:
    imprimir_despedida
    MOV 	EAX, sys_exit     ; Código de la función "sys_exit".
    XOR 	EBX, EBX          ; Valor de retorno de la función.
    INT 	0x80              ; EJEcuciuón de la interrupción.
;