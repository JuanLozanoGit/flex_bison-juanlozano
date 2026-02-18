## 1. Configuracion del Entorno de Desarrollo

Para poder compilar y ejecutar estos archivos en un entorno Linux, es indispensable contar con el generador de escaneres Flex, el generador de parsers Bison y el compilador GCC.

**Instalacion de herramientas:**
```bash
sudo apt update && sudo apt install flex bison build-essential

Acceso a la carpeta del proyecto:
Asumiendo que el repositorio fue descargado en la carpeta de Descargas y la carpeta se llama flex_bison-juanlozano:
cd ~/Downloads/flex_bison-juanlozano

2. Guia de Compilacion y Pruebas
A. Analisis Lexico (Archivos .l)
Estos programas procesan texto caracter por caracter para identificar patrones mediante expresiones regulares.
 * Contador de Palabras (Ejemplo 1-1):
   Identifica lineas, palabras y caracteres.
   flex contador_de_palabras_ejemplo1.l
gcc lex.yy.c -o wc_flex -lfl
./wc_flex < prueba_wc.txt

 * Traductor de Variantes de Ingles (Ejemplo 1-2):
   Realiza sustituciones lexicas directas (UK a US).
   flex traductor_ingles_ejemplo_2.l
gcc lex.yy.c -o traductor -lfl
./traductor < prueba_traductor.txt

 * Escaneo de Tokens de Calculadora (Ejemplos 1-3 y 1-4):
   Clasifica numeros y operadores asignandoles un valor numerico interno.
   # Compilacion del ejemplo 1-4
flex escaner_tokens_ejemplo_4.l
gcc lex.yy.c -o tokens4 -lfl
./tokens4 < prueba_calc.txt

B. Analisis Sintactico (Archivos .y + .l)
En estos ejercicios, Bison define las reglas gramaticales y utiliza a Flex como su proveedor de tokens para realizar calculos.
 * Calculadora con Manejo de Comentarios (Ejercicio 1):
   Permite que el usuario ingrese lineas vacias o comentarios iniciando con #.
   bison -d comentario_ejercicio_1.y
flex escaner_tokens_ejemplo_4.l
gcc comentario_ejercicio_1.tab.c lex.yy.c -o calc_com -lfl
./calc_com < prueba_calc.txt

 * Calculadora Hexadecimal (Ejercicio 2):
   Soporta entradas mixtas como 15 + 1 o 0xF + 1.
   bison -d calculadora_ejercicio_2.y
flex escaner_tokens_ejemplo_4.l
gcc calculadora_ejercicio_2.tab.c lex.yy.c -o calc_hex -lfl
./calc_hex < prueba_calc.txt

 * Contador de Palabras Manual en C (Ejercicio 6):
   Implementacion sin herramientas generadoras para comparativa de rendimiento.
   gcc comparativa_c_ejercicio_6.y -o wc_c_puro
./wc_c_puro < prueba_wc.txt

3. Resolucion Detallada de Ejercicios
Ejercicio 1: Soporte de Comentarios
 * Pregunta: ¿Aceptara la calculadora una linea que contenga solo un comentario?
 * Respuesta: Originalmente no. El escaner ignora el texto del comentario, pero el Parser espera una expresion valida antes del EOL. Al no recibir nada mas que el fin de linea, se genera un error de sintaxis.
 * Solucion: Se modifico la gramatica en comentario_ejercicio_1.y para que el simbolo calclist acepte un EOL solitario. Es mas eficiente corregirlo en el Parser ya que define la estructura legal de la gramatica.
Ejercicio 2: Conversion Hexadecimal
Se implemento el reconocimiento del patron 0x[a-fA-F0-9]+ en el archivo lexico. La conversion de la cadena de texto a valor numerico se realiza mediante la funcion de C strtol(yytext, NULL, 16). Esto permite que el sistema maneje enteros de 32 bits y realice operaciones aritmeticas transparentes entre bases.
Ejercicio 3: Ambiguedad del Operador "|"
El uso del simbolo | tanto para el operador binario OR como para el valor absoluto unario genera un conflicto de ambiguedad conocido como Shift/Reduce.
 * Conflicto: Ante la entrada 4 | 5, el parser no puede decidir si cerrar una operacion unaria previa o iniciar una binaria.
 * Solucion: Se requiere el uso de %left y %right en Bison para forzar la precedencia de operadores.
Ejercicio 4: Escaner Manual vs Flex
El escaner manual del Ejemplo 1-4 reconoce exactamente los mismos tokens que Flex. Sin embargo, Flex es superior tecnicamente porque genera un Automata Finito Determinista (DFA) optimizado, mientras que el escaner manual depende de una logica de switch-case que es mas lenta en archivos extensos.
Ejercicio 5: Limitaciones de Flex
Flex no es la herramienta ideal para lenguajes donde:
 * La indentacion tiene valor semantico (como Python).
 * Se requiere un analisis de contexto infinito para categorizar un token.
 * El lenguaje no es regular (no puede ser descrito por expresiones regulares simples).
Ejercicio 6: Rendimiento C vs Flex
La version en C puro (wc_c_puro) suele ser ligeramente mas veloz porque no tiene el overhead de las tablas de transicion de estados de Flex. No obstante, Flex es preferible en entornos de produccion debido a su facilidad para escalar y mantener la logica del lenguaje.
4. Limpieza de Archivos
Para eliminar los archivos intermedios y binarios generados:
rm -f lex.yy.c *.tab.c *.tab.h wc_flex traductor tokens4 calc_hex calc_com wc_c_puro

Autor
 * Nombre: Juan Lozano
 * Institucion: Universidad Sergio Arboleda
 * Fecha: Febrero 2026
