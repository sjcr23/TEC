; Tarea #2 : Función Aritmética → f(x) = a*x + b*b + 1

; Grupo #2 :
;   → Josué Castro Ramírez     -  2020065036
;   → Jesús Cordero Díaz       -  2020081049
;   → Jonathan Camacho Tencio  -  2019083743

%macro exit 0
    MOV  EAX, sys_exit                                                           ; Opción de sys_exit.
    XOR  EBX, EBX                                                                ; Set EBX en 0.
    INT  0x80                                                                    ; Interrupción al Kernel Linux.
%endmacro


%macro print 2
    MOV  EAX, sys_write                                                          ; Opción de sys_write.
    MOV  EBX, stdout                                                             ; Salida estándar.
    MOV  ECX, %1                                                                 ; Mensaje a Imprimir
    MOV  EDX, %2                                                                 ; Longitud del mensaje.
    INT  0x80                                                                    ; Interrupción al Kernel Linux.
%endmacro


%macro funcion 0
    MOV  EAX, [b]                                                                ; Pongo el valor de b en EAX.
    MOV  EBX, [b]                                                                ; Pongo el valor de b en EBX.
    MUL  EBX                                                                     ; Multiplico EBX * EAX y se almacena en EAX.

    MOV  [num], EAX                                                              ; Sumo EAX al valor de num.
    
    MOV  EAX, [a]                                                                ; Pongo el valor de a en EAX.
    MOV  EBX, [x]                                                                ; Pongo el valor de x en EBX.
    MUL  EBX                                                                     ; Multiplico EBX * EBX y lo almaceno en EAX.

    ADD  EAX, [num]                                                              ; Sumo a EAX el valor de num.
    ADD  EAX, 1                                                                  ; Sumo a EAX el valor 1.
%endmacro


%macro validar_num 0                                                             ; Realiza las validaciones.
    CMP  EAX, 200                                                                ; Compara EAX con 200.
    JG   GREATER                                                                 ; Si es mayor salta a GREATER.

    CMP  EAX, 100                                                                ; Compara EAX con 100.
    JL   LOWER                                                                   ; Si es menor salta a LOWER.

    JMP  ELSE                                                                    ; Si lo anterior no pasa; salta a ELSE.
%endmacro

section .bss
    num         RESD  4                                                          ; Reservar el espacio para un entero. (1<<32)
    num_len     EQU   $-num

section .data         
    sys_exit:   EQU   1                                                          ; Opciones de Linux.
    sys_write:  EQU   4
    stdin:      EQU   0
    stdout:     EQU   1

    NULL:       EQU   0                                                          ; Valores de ASCII (NULL).
    CR:         EQU   13                                                         ; Valores de ASCII (carriage return).
    NL:         EQU   10                                                         ; Valores de ASCII (new line).

    r:          DD    0	                                                         ; Variables Numéricas.
    x:          DD    5
    a:          DD    20
    b:          DD    10

    msgG:       DB    'f(x): 200 < Resultado.', NULL, CR, NL                     ; Mensajes a imprimir.
    lenG:       EQU   $-msgG

    msgL:       DB    'f(x): Resultado < 100.', NULL, CR, NL
    lenL:       EQU   $-msgL

    msgE:       DB    'f(x): 100 <= Resultado <= 200.', NULL, CR, NL
    lenE:       EQU   $-msgE

section .text
    global _start                                                                ; Inicio del programa.


_start:
    XOR EAX, EAX                                                                 ; Limpia EAX.
    XOR ECX, ECX                                                                 ; Limpia ECX.
    XOR EDX, EDX                                                                 ; Limpia EDX.

    funcion 
    validar_num 
    exit


GREATER:
    print msgG, lenG
    exit


LOWER:
    print msgL, lenL
    exit


ELSE:
    print msgE, lenE
    exit


MULTI:
    MOV  EAX, 1
    MUL EBX
    MUL ECX
    RET
