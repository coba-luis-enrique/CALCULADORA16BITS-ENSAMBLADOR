;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID
;LENGUAJES Y AUTOMATAS II
;M.M.M.D. JOSE LEONEL PECH MAY 
;GRADO: SEXTO SEMESTRO GRUPO:A 
;REALIZADO POR; LUIS ENRIQUE COBA KAUIL 
;ALEXIS ROBERTO PUC HUCHIM 
;PROGRAMA INFORMATICO
;I.	INSTRUCCIONES: REALIZA UN PROGRAMA QUE PERMITA EJEMPLIFICAR 
;LA GENERACION DE CODIGO OBJETO A TRAVES DE CODIGO ENSAMBLADOR O SIMIL.
;UNIDAD 4
;GENERACION DE CODIGO OBJETO

;---------------------------------------------------------------
;FILE: CALCULDARA.ASM                                            
;PROGRAMA DE CALCULADORA DE 16 BITS
;---------------------------------------------------------------

    
    ; IMPRIMIR CADENA A SALIDA        
    PSTRING MACRO STR  ;(TIPO NEAR) ( MACRO 3 )
        MOV AH,09H
        LEA DX,STR
        INT 21H
    ENDM
   
    ; OBTENER ENTRADA CARACTER  
    GETINPUT MACRO INPUT ;( MACRO 4)  
    
        
        MOV AH, 01H     ; RECIBIR ENTRADA, PAUSA Y ESPERA A QUE EL USUARIO PRECIONE UNA TECLA         
        INT 21H         ; LLAMAS AL SERVICIO DOS
    
        MOV INPUT, AL   ; ALMACENAR EN LA VARIABLE DE ENTRADA  
    ENDM
    
    
    GETINPUT2 MACRO INPUT   ;MACRO PARA INGRESAR DOS DIGITOS ( MACRO 5) 
         
        MOV AH, 09
        LEA DX, MSJN1
        INT 21H
        MOV AH, 01  ; RECIBIR ENTRADA, PAUSA Y ESPERA A QUE EL USUARIO PRECIONE UNA TECLA
        INT 21H
        SUB AL, 30H
        MOV NUMERO1,AL
        
        MOV AH, 01     ; RECIBIR ENTRADA, PAUSA Y ESPERA A QUE EL USUARIO PRECIONE UNA TECLA
        INT 21H
        SUB AL, 30H
        ADD NUMERO2,AL
        
        ;UNIR LOS DOS NUMEROS
        MOV AL, NUMERO1 ;DECENAS 
        MOV BL,10
        MUL BL        
        ADD AL, NUMERO2;UNIDADES
        MOV INPUT, AL; GUARDAMOS EL VAL0R
        
    ENDM
    
    
    
    
    
    .MODEL            ;DIRECTIVA, DEFINE EL TAMAÑO EN MEMORIA   
    .STACK                   ;ASIGANA TAMAÑO AL SEGMENTO DE PILA
    .DATA      
         
       ;DECLARANDO VARIABLES GLOBALES
         
       
       MENSAJE DB 13,10,'BIENVENIDOS A MI PROGRAMA$'
       MENSAJEDOS DB 13,10,'SOY UNA CALCULADORA DE 16 BITS :)$'
       MENSAJESDOS DB 13,10,'IMPORTANTE: SOLO RECIBO DOS DIGTOS$'
       MENSAJESTRES DB 13,10,'EJEMPLOS: 05,90,01,99$'
       MENSAJESCUATRO DB 13,10,'SI USTED PONE: 5, 3, ESTO GENERARA ERROR EN LA OPERACION$'
       MENSAJECUATRO DB 13,10,'----------------------------------------------$ '
       MENSAJECINCO DB 13,10,'1.- SUMA$'
       MENSAJESEIS DB 13,10,'2.- RESTA$' 
       MENSAJESIETE DB 13,10,'3.- MULTIPLICACION$' 
       MENSAJEOCHO DB 13,10,'4.- DIVISION$' 
       LINEA DB 13,10,'SELECCIONE UNA OPCION: $'
       MENSAJEDIVISION DB 13,10,'ESTA CALCULADORA NO DA DECIMALES$'
       MENSAJEDIVISION1 DB 13,10,'SINO ALMACENA EL RESIDUO EN UNA VARIABLE Y LA MUESTRA$'  
       CHAR DB ?   ; ALMACENAR ENTRADA DE CARACTERES
 
       VALOR1 DB 0 ;PARA GUARDAR DOS VALORES
       VALOR2 DB 0  

       ;-----------------------------------------------------------
       
       
       NUMERO1 DB 0
       NUMERO2 DB 0
       NUMUNO  DB 0
       NUMDOS  DB 0
       NUMTRES  DB 0
       NUMCUATRO  DB 0
       RESIDUO DB 0   
        
       SUMA DB 0   
       DIVIDE DB 0
       MULTIPLICACION DB 0  
       RESTAN DB 0
       R1    DB ? ;RESULTADO 1
       R2    DB ? ;RESULTADO 2
       R3    DB ?
       R4    DB ? 
       R5    DB ? 
       R6    DB ?
       AC    DB 0 ;ACARREO
       AC1   DB 0

       MSJN1 DB 10,13, "INGRESE LOS NUMEROS : ",'$';INGRESE N1   
       MSJNS DB 10,13, "LA SUMA ES= ",'$'
       MSJND DB 10,13, "LA DIVISION ES= ",'$'
       MSJNM DB 10,13, "LA MULTIPLICACION ES= ",'$'
       MSJNRE DB 10,13, "EL RESIDUO DE LA DIVISION ES= ",'$' 
       
       MSJNRMAYOR DB 10,13, "LA RESTA ES= ",'$'
       MSJNRMENOR DB 10,13, "LA RESTA ES= ",'-$'
       MSJNUNO DB 10,13, "PRESIONE ENTER PARA CONTINUAR.. Y CUALQUIER OTRA TECLA PARA SALIR'$'"
       
      
    
    .CODE 
    
     
        
        MOV AX, @DATA
        MOV DS,AX 
        
        INI:  
        
        
        
        PSTRING MENSAJE  ;IMPRIMIR MENSAJE  
        PSTRING MENSAJEDOS  ;IMPRIMIR MENSAJE
        PSTRING MENSAJECUATRO  ;IMPRIMIR MENSAJE
        PSTRING MENSAJESDOS  ;IMPRIMIR MENSAJE  
        PSTRING MENSAJESTRES  ;IMPRIMIR MENSAJE  
        PSTRING MENSAJESCUATRO  ;IMPRIMIR MENSAJE    

                   
       
    
        ;DIRECCIONAMIENTO DEL PROCEDIMIENTO
         
        MOV VALOR1,0
        MOV VALOR2,0
        MOV NUMERO1,0
        MOV NUMERO2,0
        
        ;SOLICITAR DEL TECLADO NUMERO 1
        
        GETINPUT2 VALOR1
        
        ;BORRAMOS REGISTROS
            
        MOV NUMERO1,0
        MOV NUMERO2,0  
        

        ;SOLICITAR DEL TECLADO NUMERO 2
        GETINPUT2 VALOR2  
        
        ;LIMPIAMOS EL REGISTRO
        
        PSTRING MENSAJECUATRO  ;IMPRIMIR MENSAJE
        PSTRING MENSAJECINCO  ;IMPRIMIR MENSAJE
        PSTRING MENSAJESEIS  ;IMPRIMIR MENSAJE
        PSTRING MENSAJESIETE  ;IMPRIMIR MENSAJE
        PSTRING MENSAJEOCHO  ;IMPRIMIR MENSAJE 
        
        PSTRING LINEA  ;IMPRIMIR MENSAJE
        GETINPUT CHAR
        
        ;PARA HACER FUNCIONAR AL MENU
        CMP AL,31H ; SI AL=1 SALTA HACIA SUMA
        JE SUM
        CMP AL,32H ; SI AL=1 SALTA HACIA RESTA
        JE RESTA
        CMP AL,33H ; SI AL=1 SALTA HACIA MULTIPLICACION
        JE MULT
        CMP AL,34H  ;; SI AL=1 SALTA HACIA DIVISION
        JE DIVISION
        
        
        SUM:
        
            ;LIMPIAMOS LOS RESGISTROS
            ;=======================================
            MOV AX,0
            MOV BX,0
            MOV CX,0
            MOV DX,0 
            ;===========================================
            
            MOV AL,VALOR1   ;MOV NUMERO1 A AL
            ADD AL,VALOR2    ; SUMA NUMERO1 * NUMERO2
            MOV SUMA,AL      ;SUMA=AL
            MOV AH,09
            LEA DX,MSJNS  ;LEE LA VARIABLE MSJNS Y SE ASIGNA A DX
            INT 21H
            MOV DL,SUMA ;DL=SUMA
            
            MOV AL,0     ;BORRAMOS EL REGISTRO AL
            MOV AL,SUMA   ;LE ASIGNAMOS EL VALOR DE SUMA
            
     
            
            AAM ; AJUSTA EL VALOR EN AL POR: AH Y AL
    
            MOV R4,AL ; RESPALDO  EN UNIDADES
            MOV AL,AH ;MUEVO LO QUE TENGO EN AH A AL PARA PODER VOLVER A SEPARAR LOS NUMEROS
            
            AAM ; SEPARA LO QE HAY EN AL POR: AH=2 Y AL=3
            MOV R2,AH ;RESPALDO LAS CENTENAS EN CEN 
            
            MOV R3,AL ;RESPALDO LAS DECENAS EN DEC
            
            
            ;IMPRIMOS LOS TRES VALORES EMPEZANDO POR CENTENAS, DECENAS Y UNIDADES.
            
            MOV AH,02H
            
            MOV DL,R2
            ADD DL,30H ; SE SUMA 30H A DL PARA IMPRIMIR EL NUMERO REAL.
            INT 21H
            
            MOV DL,R3
            ADD DL,30H
            INT 21H
            
            MOV DL,R4
            ADD DL,30H
            INT 21H
            
            ;HACER FUNCIONAR EL CICLO PARA VOLVER AL INICIO O SALIR DEL PROGRAMITA
            
            PSTRING MSJNUNO  ;IMPRIMIR MENSAJE
            PSTRING LINEA  ;IMPRIMIR MENSAJE
            GETINPUT CHAR  
            
            ;S PARA CONTINUAR Y N PARA SALIR
            CMP AL,0DH  ;0DH ES ENTER
            JNE FINAL
            MOV AH, 00H ;FUNCION PARA HACER SCROLL TAMBIEN CON 7H
            MOV AL,0H ;CANTIDAD DE FILAS A ENROLLAR
            MOV BH, 07H;ATRIBUTOS DE COLOR FONDO Y TEXTO
            MOV CX,00H;FILA INICIAL EN CH, COLUMNA INICIAL EN CL
            MOV DX, 184FH;FILA FINAL EN DH, COLUMNA FINAL EN CL
            INT 10H;EJECUTA LAS INTERRUPCIONES DE VIDEO
            JE INI ;SALTA AL COMIENZO SI LA TECLA PRESIONADA NO FUE ENTER  
            FINAL:
            
            MOV AH, 4CH  ; PROGRAMA FIN
            INT 21H
            
        
        MULT:
        
            ;LIMPIAMOS LOS REGISTROS
            MOV AX,0
            MOV BX,0
            MOV CX,0
            MOV DX,0
    
            ;DESGLOZAMOS LOS NUMEROS DE VALOR 1 Y VALOR 2 EN UNIDADES DE 8 BITS
            MOV AL,VALOR1   ;MOV NUMERO1 A AL
            AAM ;AJUSTAMOS VALORES
            MOV NUMUNO,AH ;DECENAS
            MOV NUMDOS,AL ;UNIDADES
            MOV AL,VALOR2   ; NUMERO1 * NUMERO2
            AAM
            MOV NUMTRES,AH  ;DECENAS
            MOV NUMCUATRO,AL ;UNIDADES
            MOV AH,09
            LEA DX,MSJNM  ;LEE LA VARIABLE MSJNS Y SE ASIGNA A DX
            INT 21H
            
    
              
            MOV AL,NUMCUATRO  ;UNIDAD DEL SEGUNDO NUMERO
            MOV BL,NUMDOS  ;UNIDAD DEL PRIMER NUMERO
            MUL BL       ;MULTIPLICAR
            MOV AH,0     ;LIMPIAMOS AH0
            AAM          ;SEPARAMOS DE HEX A DEC
            MOV AC1,AH   ;DECENAS DEL PRIMERA MULTIPLICACION
            MOV R4,AL    ;UNIDADES DEL PRIMERA MULTIPLICACION
                    
            MOV AL,NUMCUATRO  ;UNIDADES DEL SEGUNDO NUMERO
            MOV BL,NUMUNO  ;DECENTAS DEL PRIMER NUMERO
            MUL BL       ;MULTIPLICAR
            MOV R3,AL    ;MOVEMOS EL RESULTADO DE LA OPERACION A R3
            MOV BL,AC1   ;MOVEMOS EL ACARREO A BL
            ADD R3,BL    ;SUMAMOS RESULTADO MAS ACARREO
            MOV AH,00H   ;LIMPIAMOS AH POR RESIDUOS
            MOV AL,R3    ;MOVEMOS EL RESULTADO DE LA SUMA A AL
            AAM          ;SEPARAMOS  DE HEX A DEC
            MOV R3,AL    ;GUARDAMOS UNIDADES EN R3
            MOV AC1,AH   ;GUARDAMOS DECENAS EN AC1
        
            MOV AL,NUMTRES    ;AL = CHR3
            MOV BL,NUMDOS    ;BL = CHR2
            MUL BL         ;AL = CHR3*CHR2 (BL*AL)
            MOV AH,0H      ;
            AAM            ;ASCII ADJUSMENT
            MOV AC,AH      ;AC = AH (ACARREO)
            MOV R2,AL      ;R2 = AL       (UNIDAD DEL RESULTADO)
        
            MOV AL,NUMTRES    ;AL = CHR3
            MOV BL,NUMUNO    ;BL = CHR1
            MUL BL         ;AL = CHR1*CHR3 (BL*AL)
            MOV R1,AL      ;R1 = AL       (DECENA DEL RESULTADO)
            MOV BL,AC      ;BL = ACARREO ANTERIOR
            ADD R1,BL      ;R1 = R1+AC (R1 + ACARREO)
            MOV AH,00H     ;
            MOV AL,R1      ;AL = R1 (ASIGNACI?N PARA EL AJUST)
            AAM            ;ASCII ADJUSTMENT
            MOV R1,AL      ;R1 = AL
            MOV AC,AH      ;AC = AH (ACARREO PARA LA CENTENA DEL RESULTADO)
          
          
           ;SUMA FINAL
           ;R4 RESULTA SER LAS UNIDADES DE MUL Y NO SE TOMA EN CUENTA YA QUE SE PASA ENTERO
          
          
            MOV AX,0000H   ;LIMPIAMOS AX
          
            MOV AL,R3      ;MOVEMOS EL SEGUNDO RESULTADO DE LA PRIMERA MULT A AL
            MOV BL,R2      ;MOVEMOS PRIMER RESULTADO DE LA SEGUNDA MULT A BL
            ADD AL,BL      ;SUMAMOS
            MOV AH,00H     ;LIMPIAMOS AH
            AAM            ;SEPARAMOS HEX A DEC
            MOV R3,AL      ;R3 GUARDA LAS DECENAS DEL RESULTADO FINAL
            MOV R2,AH      ;R2 SE UTILIZA COMO NUEVO ACARREO
          
            MOV AX,0000H   ;''''
          
            MOV AL,AC1     ;MOVEMOS EL ACARREO DE LA PRIMERA MULT A AL
            MOV BL,R1      ;MOVEMOS SEGUNDO RESULTADO DE LA SEGUNDA MULT A BL
            ADD AL,R2      ;SUMAMOS EL NUEVO  ACARREO DE LA SUMA ANTERIOR  A AL
            ADD AL,BL      ;SUMAMOS AL A BL
            MOV AH,00H     ;LIMPIAMOS EL REGISTRO AH
            AAM            ;SEPARAMOS DE HEX A DEC
            MOV R1,AL      ;R1 GUARDA LAS CENTENAS
            MOV R2,AH      ;AH SE SIGUE UTILIZANDO COMO ACARREO
          
            MOV AL,R2      ;MOVEMOS EL ACARREO A AL
            MOV BL,AC      ;MOVEMOS AC A BL
            ADD AL,BL      ;SUMAMOS AL A BL
            ;AAM            ;SEPARAMOS HEX A DEC
            MOV AC,AL      ;MOV AL A AC COMO NUESTRO ACARREO FINAL
          
            ;APLICAMOS LO MISMO QUE EN LA SUMA
          
            ;MOSTRAMOS RESULTADO
            MOV AH,02H 
            MOV DL,AC
            ADD DL,30H
            INT 21H        ;MOSTRAMOS AC (MILLAR)
        
            MOV AH,02H
            MOV DL,R1
            ADD DL,30H
            INT 21H        ;MOSTRAMOS R1 (CENTENA)
    
            MOV AH,02H
            MOV DL,R3
            ADD DL,30H
            INT 21H        ;MOSTRAMOS R3 (DECENA)
          
            MOV AH,02H
            MOV DL,R4
            ADD DL,30H 
            INT 21H 
            
            ;PARA HACER FUNCIONAR LOS CICLOS
            
            PSTRING MSJNUNO  ;IMPRIMIR MENSAJE
            PSTRING LINEA  ;IMPRIMIR MENSAJE
            GETINPUT CHAR
            ;S PARA CONTINUAR Y N PARA SALIR
            CMP AL,0DH  ;0DH ES ENTER
            JNE FINAL2
            MOV AH, 00H ;FUNCION PARA HACER SCROLL TAMBIEN CON 7H
            MOV AL,0H ;CANTIDAD DE FILAS A ENROLLAR
            MOV BH, 0FH;ATRIBUTOS DE COLOR FONDO Y TEXTO
            MOV CX,00H;FILA INICIAL EN CH, COLUMNA INICIAL EN CL
            MOV DX, 184FH;FILA FINAL EN DH, COLUMNA FINAL EN CL
            INT 10H;EJECUTA LAS INTERRUPCIONES DE VIDEO
            JE INI ;SALTA AL COMIENZO SI LA TECLA PRESIONADA NO FUE ENTER  
            FINAL2:
            
            MOV AH, 4CH  ; PROGRAMA FIN
            INT 21H 
       
        RESTA:   
        
            ;LIMPIAMOS LOS REGISTROS
            XOR AX,AX
            XOR BX,BX
            XOR CX,CX 
            XOR DX,DX
            MOV RESTAN,0
            
            
            ;HAREMOS COMPARACIONES 
            ;PREVIAMENTE A ESTE CASO, VAMOS A LIMPIAR LOS REGISTROS
            
            ;DESGLOZAMOS LOS NUMEROS DE VALOR 1 Y VALOR 2 EN UNIDADES DE 8 BITS
            
            MOV AL,VALOR1   ;MOV NUMERO1 A AL
            AAM
            MOV NUMUNO,AH ;DECENAS
            MOV NUMDOS,AL ;UNIDADES 
            MOV AL,0
            MOV AL,VALOR2
            AAM
            MOV NUMTRES,AH  ;DECENAS
            MOV NUMCUATRO,AL ;UNIDADES
            MOV AH,09
       
            
            MOV BL,NUMTRES
            MOV DL,NUMUNO      
            CMP DL,BL
            JG  MAYOR ;SI ES MAYOR SALTO A MAYOR
            JL  MENOR ;SI ES MENOR SALTA A LA ETIQUETA MENOR
            JE  COMPARARUNIDADES ;PERO SI SON IGUALES LAS DECENAS SALTA A LA COMPARACION DE UNIDADES
            
            COMPARARUNIDADES: ;COMPARAS LAS UNIDADES DE VALOR1 Y VALOR
            MOV BH,0          ;BORRAMOS REGISTRO DE LA PARTA BAJA DE BX
            MOV BH,NUMCUATRO  ; LE ASIGNAMOS LA UNIDAD DE VALOR2
            MOV DH,0          ; BORRAMOS LA PARTE BAJA DE AX Y LE ASIGAMOS LA UNIDAD DE VALOR 1
            MOV DH,NUMDOS
            CMP DH,BH       ;COMPARAMOS
            JG  MAYOR 
            JL MENOR
            JE MAYOR
            
            MAYOR:
            MOV AL,VALOR1   ;MOV NUMERO1 A AL
            SUB AL,VALOR2    ; SUMA NUMERO1 * NUMERO2
            MOV RESTAN,AL 
            JMP PROCEMIENTOMAYOR
            
            MENOR:
            MOV AL,VALOR2   ;MOV NUMERO1 A AL
            SUB AL,VALOR1    ; SUMA NUMERO1 * NUMERO2   
            
            MOV RESTAN,AL 
            
            JMP PROCEMIENTOMENOR 
             
            PROCEMIENTOMAYOR:
            MOV AH,09
            LEA DX,MSJNRMAYOR  ;LEE LA VARIABLE MSJNS Y SE ASIGNA A DX
            INT 21H
            MOV DL,RESTAN
            
            MOV AL,0 
            MOV AL,RESTAN
            
            ;EJEMPLO LA SUMA ES 123, PARA AJUSTAR LOS VALORES AAM
            
            AAM ; AJUSTA EL VALOR EN AL POR: AH=23 Y AL=4  
    
            MOV R4,AL ; RESPALDO  EN UNIDADES
            MOV AL,AH ;MUEVO LO QUE TENGO EN AH A AL PARA PODER VOLVER A SEPARAR LOS NUMEROS
            
            AAM ; SEPARA LO QE HAY EN AL POR: AH=2 Y AL=3
            MOV R2,AH ;RESPALDO LAS CENTENAS EN CEN EN ESTE CASO 2
            
            MOV R3,AL ;RESPALDO LAS DECENAS EN DEC, EN ESTE CASO 3
            
            
            ;IMPRIMOS LOS TRES VALORES EMPEZANDO POR CENTENAS, DECENAS Y UNIDADES.
            
            MOV AH,02H
            
            MOV DL,R2
            ADD DL,30H ; SE SUMA 30H A DL PARA IMPRIMIR EL NUMERO REAL.
            INT 21H
            
            MOV DL,R3
            ADD DL,30H
            INT 21H
            
            MOV DL,R4
            ADD DL,30H
            INT 21H
            
            PSTRING MSJNUNO  ;IMPRIMIR MENSAJE
            PSTRING LINEA  ;IMPRIMIR MENSAJE
            GETINPUT CHAR
            ;S PARA CONTINUAR Y N PARA SALIR
            CMP AL,0DH  ;0DH ES ENTER
            JNE FINAL3
            MOV AH, 00H ;FUNCION PARA HACER SCROLL TAMBIEN CON 7H
            MOV AL,0H ;CANTIDAD DE FILAS A ENROLLAR
            MOV BH, 07H;ATRIBUTOS DE COLOR FONDO Y TEXTO
            MOV CX,00H;FILA INICIAL EN CH, COLUMNA INICIAL EN CL
            MOV DX, 184FH;FILA FINAL EN DH, COLUMNA FINAL EN CL
            INT 10H;EJECUTA LAS INTERRUPCIONES DE VIDEO
            JE INI ;SALTA AL COMIENZO SI LA TECLA PRESIONADA NO FUE ENTER  
            FINAL3:
            
            MOV AH, 4CH  ; PROGRAMA FIN
            INT 21H
            
            
            PROCEMIENTOMENOR:
            MOV AH,09
            LEA DX,MSJNRMENOR  ;LEE LA VARIABLE MSJNS Y SE ASIGNA A DX
            INT 21H
            MOV DL,RESTAN
            
            MOV AL,0 
            MOV AL,RESTAN
            
            ;EJEMPLO LA SUMA ES 123, PARA AJUSTAR LOS VALORES AAM
            
            AAM ; AJUSTA EL VALOR EN AL POR: AH=23 Y AL=4  
    
            MOV R4,AL ; RESPALDO  EN UNIDADES
            MOV AL,AH ;MUEVO LO QUE TENGO EN AH A AL PARA PODER VOLVER A SEPARAR LOS NUMEROS
            
            AAM ; SEPARA LO QE HAY EN AL POR: AH=2 Y AL=3
            MOV R2,AH ;RESPALDO LAS CENTENAS EN CEN EN ESTE CASO 2
            
            MOV R3,AL ;RESPALDO LAS DECENAS EN DEC, EN ESTE CASO 3
            
            
            ;IMPRIMOS LOS TRES VALORES EMPEZANDO POR CENTENAS, DECENAS Y UNIDADES.
            
            MOV AH,02H
            
            MOV DL,R2
            ADD DL,30H ; SE SUMA 30H A DL PARA IMPRIMIR EL NUMERO REAL.
            INT 21H
            
            MOV DL,R3
            ADD DL,30H
            INT 21H
            
            MOV DL,R4
            ADD DL,30H
            INT 21H
            
            PSTRING MSJNUNO  ;IMPRIMIR MENSAJE
            PSTRING LINEA  ;IMPRIMIR MENSAJE
            GETINPUT CHAR
            ;S PARA CONTINUAR Y N PARA SALIR
            CMP AL,0DH  ;0DH ES ENTER
            JNE FINAL4
            MOV AH, 00H ;FUNCION PARA HACER SCROLL TAMBIEN CON 7H
            MOV AL,0H ;CANTIDAD DE FILAS A ENROLLAR
            MOV BH, 07H;ATRIBUTOS DE COLOR FONDO Y TEXTO
            MOV CX,00H;FILA INICIAL EN CH, COLUMNA INICIAL EN CL
            MOV DX, 184FH;FILA FINAL EN DH, COLUMNA FINAL EN CL
            INT 10H;EJECUTA LAS INTERRUPCIONES DE VIDEO
            JE INI ;SALTA AL COMIENZO SI LA TECLA PRESIONADA NO FUE ENTER  
            FINAL4:
            
            MOV AH, 4CH  ; PROGRAMA FIN
            INT 21H
            
            
        DIVISION:
            
            PSTRING MENSAJEDIVISION
            PSTRING MENSAJEDIVISION1
            
            MOV AX,0
            MOV BX,0
            MOV CX,0
            MOV DX,0
            
            MOV BL,VALOR2   ;MOV NUMERO1 A AL
            MOV AL,VALOR1    ; SUMA NUMERO1 * NUMERO2
            DIV BL 
            MOV DIVIDE,AL 
            MOV RESIDUO,AH 
            
            MOV AH,09
            LEA DX,MSJND  ;LEE LA VARIABLE MSJNS Y SE ASIGNA A DX
            INT 21H
            MOV DL,DIVIDE
            
            MOV AL,0 
            MOV AL,DIVIDE
            
            ;EJEMPLO LA SUMA ES 123, PARA AJUSTAR LOS VALORES AAM
            
            AAM ; AJUSTA EL VALOR EN AL POR: AH=23 Y AL=4  
    
            MOV R4,AL ; RESPALDO  EN UNIDADES
            MOV AL,AH ;MUEVO LO QUE TENGO EN AH A AL PARA PODER VOLVER A SEPARAR LOS NUMEROS
            
            AAM ; SEPARA LO QE HAY EN AL POR: AH=2 Y AL=3
            MOV R2,AH ;RESPALDO LAS CENTENAS EN CEN EN ESTE CASO 2
            
            MOV R3,AL ;RESPALDO LAS DECENAS EN DEC, EN ESTE CASO 3
            
            
            ;IMPRIMOS LOS TRES VALORES EMPEZANDO POR CENTENAS, DECENAS Y UNIDADES.
            
            MOV AH,02H
            
            MOV DL,R2
            ADD DL,30H ; SE SUMA 30H A DL PARA IMPRIMIR EL NUMERO REAL.
            INT 21H
            
            MOV DL,R3
            ADD DL,30H
            INT 21H
            
            MOV DL,R4
            ADD DL,30H
            INT 21H 
            
            ;APARTADO RESIDUO  
            XOR AX,AX ;BORRAMOS REGISTROS
            MOV AH,09
            LEA DX,MSJNRE  ;LEE LA VARIABLE MSJNS Y SE ASIGNA A DX
            INT 21H  
            MOV DL,RESIDUO
            
            MOV AL,0 
            MOV AL,RESIDUO
            
            AAM ; AJUSTA EL VALOR EN AL POR: AH=23 Y AL=4  
    
            MOV R6,AL ; RESPALDO  EN UNIDADES
            MOV R5,AH ; RESPALDO EN DECENAS 
            
            MOV AH,02H
            
            MOV DL,R5
            ADD DL,30H
            INT 21H
            
            MOV DL,R6
            ADD DL,30H
            INT 21H 
                     
            
            PSTRING MSJNUNO  ;IMPRIMIR MENSAJE
            PSTRING LINEA  ;IMPRIMIR MENSAJE
            GETINPUT CHAR
            ;S PARA CONTINUAR Y N PARA SALIR
            CMP AL,0DH  ;0DH ES ENTER
            JNE FINAL5
            MOV AH, 00H ;FUNCION PARA HACER SCROLL TAMBIEN CON 7H
            MOV AL,0H ;CANTIDAD DE FILAS A ENROLLAR
            MOV BH, 07H;ATRIBUTOS DE COLOR FONDO Y TEXTO
            MOV CX,00H;FILA INICIAL EN CH, COLUMNA INICIAL EN CL
            MOV DX, 184FH;FILA FINAL EN DH, COLUMNA FINAL EN CL
            INT 10H;EJECUTA LAS INTERRUPCIONES DE VIDEO
            JE INI ;SALTA AL COMIENZO SI LA TECLA PRESIONADA NO FUE ENTER  
            FINAL5:
            MOV AH, 4CH  ; PROGRAMA FIN
            INT 21H
                
END
