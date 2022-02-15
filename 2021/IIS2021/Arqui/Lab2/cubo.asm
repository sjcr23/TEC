

%macro printf 2                         ; printf(str Mensaje, int Longitud){
    MOV     EAX,     sys_write          ;   -> Invoca a SYS_WRITE (opción 4 de las interrupciones del Kernel).
    MOV     EBX,     stdout             ;   -> Escribe en el STDOUT (standar output).
    MOV     ECX,     %1                 ;   -> Mensaje.
    MOV     EDX,     %2                 ;   -> Longitud.
    INT     0x80                        ;}
%endmacro


%macro scanf 0                          ; scanf(){
    MOV     EAX,     sys_read           ;   -> Invoca a SYS_READ (opción 3 de las interrupciones del Kernel).
    MOV     EBX,     stdin              ;   -> Escribe en el STDIN (standar input).
    MOV     ECX,     input              ;   -> Dirección de memoria reservada para almacenar nuestro input (conocido como buffer).
    MOV     EDX,     8                  ;   -> Número de bytes a leer.
    INT     0x80                        ;}
%endmacro


%macro save_int 1                       ; save_int(Dirección){
    MOV     EAX ,    [input]            ;   -> Pasa la información del input a un registro.
    SUB     EAX ,    48                 ;   -> Resta 48 al número. (48 es el ASCII code de '0'.)
    MOV     [%1],    EAX                ;   -> Dirección de memoria donde se almacena el input.
%endmacro                               ;}


section .data
    ; OPCIONES DE LLAMADAS AL KERNEL.
    sys_exit            EQU     1
    sys_read            EQU     3
    sys_write           EQU     4
    stdin               EQU     0
    stdout              EQU     1

    ; MENSAJES A DESPLEGAR.
    msg0                DB      10,13,0
    msg0_len            EQU     $- msg0

    msgAncho            DB      'Ancho: '
    lenAncho            EQU     $- msgAncho

    msgLargo            DB      'Largo: '
    lenLargo            EQU     $- msgLargo

    msgAltura           DB      'Altura: '
    lenAltura           EQU     $- msgAltura

    msgResultado        DB      'El volumen es: '
    msgResultado_len    EQU     $- msgResultado
;


section .bss
    ; VARIABLES DE USO.
    input:              RESD    1
    input_len           EQU     $-input

    ; VARIABLES DEL CUBO.
    ancho:              RESD    1
    ancho_len           EQU     $-ancho

    largo:              RESD    1
    largo_len           EQU     $-largo

    altura:             RESD    1
    altura_len          EQU     $-altura

    resultado:          RESB    1
	resultado_len       EQU     $-resultado

    decenas:            RESB    1
    decenas_len         EQU     $-decenas

    unidades:           RESB    1
    unidades_len        EQU     $-unidades
;


section .text
    global _start  
;


_start: 
    ; LIMPIAR REGISTROS.
        XOR   EAX   ,   EAX
        XOR   EBX   ,   EBX
        XOR   ECX   ,   ECX
        XOR   EDX   ,   EDX
    ;


    ; CAPTURAR INPUTS.
        printf msgAncho, lenAncho             ; Solicita el ancho.
        scanf                                 ; Escanea la entrada.
        save_int ancho                        ; Guarda la entrada como INT en la dirección 'ancho'.


        printf msgLargo, lenLargo             ; Solicita el largo.
        scanf                                 ; Escanea la entrada.
        save_int largo                        ; Guarda la entrada como INT en la dirección 'largo'.


        printf msgAltura, lenAltura           ; Solicita la altura.
        scanf                                 ; Escanea la entrada.
        save_int altura                       ; Guarda la entrada como INT en la dirección 'altura'.
    ;


    ; CALCULAR RESULTADO.
        MOV   EAX   ,   [ancho]               ; Muevo las variables a un registro.
        MOV   EBX   ,   [largo]               ; Muevo las variables a un registro.
        MUL   EBX                             ; Multiplico los registros.
    
        MOV   ECX   ,   [altura]              ; Muevo las variables a un registro.
	    MUL   ECX                             ; Multiplico los registros.
    ;


    ; VALIDAR CANTIDAD DE DÍGITOS.
        CMP   AL    ,   9
        JG    calcular_dos_digitos
    ;


    ; IMPRIMIR RESULTADO.
        ADD   EAX           ,   48            ; Sumo 48 al registro para imprimir el número.
        MOV   [resultado]   ,   EAX           ; Dirección de memoria donde se almacena el resultado.

	    printf msgResultado, msgResultado_len ; Imprimo el mensaje de resultado.
        printf resultado, resultado_len       ; Imprimo el resultado.
        printf msg0, msg0_len                 ; Imprimo una nueva línea

        JMP salir
    ;
;


calcular_dos_digitos:
    
    MOV   [resultado]    ,   EAX              ; Almaceno en 'resultado' el resultado que está en EAX.

    ; CALCULO DECENAS.
        MOV   ECX        ,   10               ; Pongo un 10 en ECX.
        DIV   ECX                             ; Realizo la división.
        ADD   EAX        ,   48               ; Sumo 48 al registro para imprimir las decenas.
        MOV   [decenas]  ,   EAX              ; Almaceno en 'decenas' el resultado que está en EAX.
    ;


    ; CALCULO UNIDADES.
        SUB   EAX        ,   48               ; Resto 48 a EAX que continene ls decenas para seguir haciendo operaciones aritméticas. 
        MOV   EBX        ,   10               ; Pongo un 10 en EBX.
        MUL   EBX                             ; Multiplico.

        MOV   EDX        ,   EAX              ; Muevo ese resultado a EDX.
        MOV   EAX        ,   [resultado]      ; Muevo resultado a EAX.
        SUB   EAX        ,   EDX              ; Resto EDX a EAX.

        ADD   EAX        ,   48               ; Sumo 48 al registro para imprimir el número.
        MOV   [unidades] ,   EAX              ; 
    ;


    ; IMPRIMIR EL NÚMERO
        printf msgResultado, msgResultado_len ; Imprimo el mensaje de resultado.
        printf decenas, decenas_len           ; Imprimo las decenas.
        printf unidades, unidades_len         ; Imprimo las unidades.
        printf msg0, msg0_len                 ; Imprimo una nueva línea.
    ;

    JMP salir
;


salir:
    MOV EAX, sys_exit     ; Código de la función "sys_exit".
    XOR EBX, EBX          ; Valor de retorno de la función.
    INT 0x80              ; Ejecuciuón de la interrupción.
;