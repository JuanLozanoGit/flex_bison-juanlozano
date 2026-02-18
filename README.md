
---

Flex & Bison: Manual de Implementación - Capítulo 1

Este repositorio contiene la documentación y el código fuente para los ejemplos y ejercicios del Capítulo 1 del libro "Flex & Bison" de John Levine.

El objetivo de esta tarea es comprender la arquitectura de un compilador, separando el:

Análisis léxico (tokens)

Análisis sintáctico (gramática)



---

1. Configuración del Entorno de Desarrollo

Para poder compilar y ejecutar estos archivos en un entorno Linux, es indispensable contar con:

Flex (generador de escáneres)

Bison (generador de parsers)

GCC (compilador)


Instalación (Debian/Ubuntu)

sudo apt update
sudo apt install flex bison build-essential

Acceso a la carpeta del proyecto

Una vez descargado el repositorio:

cd ~/Downloads/flex_bison-juanlozano


---

2. Guía de Compilación y Pruebas

A. Análisis Léxico (Archivos .l)

Estos programas procesan texto carácter por carácter para identificar patrones.


---

🔹 Contador de Palabras (Ejemplo 1-1)

Identifica líneas, palabras y caracteres.

flex contador_de_palabras_ejemplo1.l
gcc lex.yy.c -o wc_flex -lfl
./wc_flex < prueba_wc.txt


---

🔹 Traductor de Variantes de Inglés (Ejemplo 1-2)

Realiza sustituciones léxicas directas.

flex traductor_ingles_ejemplo_2.l
gcc lex.yy.c -o traductor -lfl
./traductor < prueba_traductor.txt


---

🔹 Escaneo de Tokens de Calculadora (Ejemplos 1-3 y 1-4)

Clasifica números y operadores asignándoles un valor.

flex escaner_tokens_ejemplo_4.l
gcc lex.yy.c -o tokens4 -lfl
./tokens4 < prueba_calc.txt


---

B. Análisis Sintáctico (Archivos .y + .l)

En estos ejercicios:

Bison define la gramática

Flex provee los tokens



---

🔹 Calculadora Hexadecimal (Ejercicio 2)

Soporta tanto:

15 + 1
0xF + 1

bison -d calculadora_ejercicio_2.y
flex escaner_tokens_ejemplo_4.l
gcc calculadora_ejercicio_2.tab.c lex.yy.c -o calc_hex -lfl
./calc_hex < prueba_calc.txt


---

🔹 Calculadora con Manejo de Comentarios (Ejercicio 1)

Permite:

Líneas vacías

Comentarios iniciando con #


bison -d comentario_ejercicio_1.y
flex escaner_tokens_ejemplo_4.l
gcc comentario_ejercicio_1.tab.c lex.yy.c -o calc_com -lfl
./calc_com < prueba_calc.txt


---

🔹 Contador de Palabras Manual en C (Ejercicio 6)

Implementación sin herramientas generadoras para comparativa de rendimiento.

gcc comparativa_c_ejercicio_6.y -o wc_c_puro
./wc_c_puro < prueba_wc.txt


---

3. Resolución Detallada de Ejercicios


---

Ejercicio 1: Soporte de Comentarios

Pregunta:
¿Aceptará la calculadora una línea que contenga solo un comentario?

Respuesta:
Originalmente no, porque la gramática espera una expresión válida antes del fin de línea.

Cuando Flex ignora el comentario, el Parser recibe únicamente un EOL inesperado.

Solución:
Se modificó la regla calclist en el archivo .y para permitir que una línea consista únicamente en un EOL.

Es mejor corregirlo en el Parser, ya que es un problema estructural de la sentencia.


---

Ejercicio 2: Conversión Hexadecimal

Se implementó el reconocimiento del patrón:

0x[a-fA-F0-9]+

La conversión se realiza mediante:

strtol(yytext, NULL, 16)

Esto permite:

Manejar internamente enteros de 32 bits

Realizar operaciones mixtas entre decimal y hexadecimal



---

Ejercicio 3: Ambigüedad del Operador |

El símbolo | se intentó usar como:

OR binario

Valor absoluto unario


Esto genera un conflicto Shift/Reduce en Bison.

Cuando aparece el segundo |, el parser no sabe si:

Debe cerrar el valor absoluto

O continuar procesando una operación lógica


Solución:
Definir precedencia usando:

%left
%right


---

Ejercicio 4: Escáner Manual vs Flex

El escáner manual del Ejemplo 1-4 es funcionalmente equivalente al generado por Flex.

Sin embargo:

Flex genera un Autómata Finito Determinista (DFA)

Procesa cada carácter exactamente una vez

Usa tablas de transición optimizadas


Resultado:
Flex es significativamente más eficiente en archivos grandes.


---

Ejercicio 5: Limitaciones de Flex

Flex no es ideal para lenguajes donde:

El significado depende de la indentación (ej. Python)

Se requiere "lookahead" ilimitado

El token depende de contexto profundo


Esto se debe a que utiliza expresiones regulares de memoria limitada.


---

Ejercicio 6: Rendimiento C vs Flex

Comparando:

wc_c_puro

wc_flex


La versión en C suele ser ligeramente más rápida porque:

No usa infraestructura adicional de librerías


Sin embargo:

La versión Flex es más escalable

Más mantenible

Más fácil de extender



---

4. Limpieza de Archivos

Para eliminar archivos intermedios y binarios:

rm -f lex.yy.c *.tab.c *.tab.h wc_flex traductor tokens4 calc_hex calc_com wc_c_puro


---

Autor

Nombre: Juan Lozano

Institución: Universidad Sergio Arboleda

Fecha: Febrero 2026

