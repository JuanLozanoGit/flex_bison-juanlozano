# README: Flex & Bison (Capítulo 1)

Este repositorio contiene el código fuente y la documentación técnica de los ejemplos y ejercicios del primer capítulo del libro "Flex & Bison" de John Levine. El objetivo es comprender la separación de responsabilidades: el análisis léxico (Flex) y el análisis sintáctico (Bison).

## 1. Configuración del Entorno de Desarrollo

### Instalación de herramientas

```bash
sudo apt update && sudo apt install flex bison build-essential

```

### Acceso y Localización de Archivos

```bash
cd ~/Downloads/flex_bison-juanlozano-main
ls -l

```

---

## 2. Guía de Compilación y Ejecución

### A. Análisis Léxico (Archivos `.l`)

Estos archivos generan analizadores que identifican patrones mediante expresiones regulares.

* **Contador de Palabras (Ejemplo 1):**
```bash
flex contador_de_palabras_ejemplo1.l
gcc lex.yy.c -o wc_flex -lfl
./wc_flex < prueba_wc.txt

```


* **Traductor de Variantes de Inglés (Ejemplo 2):**
```bash
flex traductor_ingles_ejemplo_2.l
gcc lex.yy.c -o traductor -lfl
./traductor < prueba_traductor.txt

```


* **Reconocedor de Tokens (Ejemplo 3):**
```bash
flex reconocedor_tokens-ejemplo3.l
gcc lex.yy.c -o tokens3 -lfl
./tokens3

```



### B. Análisis Sintáctico (Integración `.y` + `.l`)

Bison requiere que el comando `bison -d` se ejecute primero para generar el archivo de cabecera `.h` que necesita Flex.

* **Calculadora con Manejo de Comentarios (Ejercicio 1):**
```bash
bison -d comentario_ejercicio_1.y
flex escaner_tokens_ejemplo_4.l
gcc comentario_ejercicio_1.tab.c lex.yy.c -o calc_com -lfl
./calc_com

```


* **Calculadora Hexadecimal (Ejercicio 2):**
```bash
bison -d calculadora_ejercicio_2.y
flex escaner_tokens_ejemplo_4.l
gcc calculadora_ejercicio_2.tab.c lex.yy.c -o calc_hex -lfl
./calc_hex < prueba_calc.txt

```


* **Análisis de Ambigüedad (Ejercicio 3):**
```bash
bison -d ambiguedad_ejercicio_3.y
flex escaner_tokens_ejemplo_4.l
gcc ambiguedad_ejercicio_3.tab.c lex.yy.c -o calc_ambig -lfl
./calc_ambig

```


* **Calculadora Completa (Ejemplo 5):**
```bash
bison -d calculadora_ejercicio_2.y
flex calculadora_completa_ejemplo_5.l
gcc calculadora_ejercicio_2.tab.c lex.yy.c -o calc_completa -lfl
./calc_completa

```


* **Comparativa C Puro (Ejercicio 6):**
```bash
gcc comparativa_c_ejercicio_6.y -o wc_c_puro 
./wc_c_puro < prueba_wc.txt

```



---

## 3. Resolución Detallada de Ejercicios

### Ejercicio 1: Soporte de Comentarios

Se modificó la gramática en `comentario_ejercicio_1.y` para permitir que la regla `calclist` acepte un `EOL` solitario. Esto evita errores cuando el escáner ignora un comentario pero deja un salto de línea huérfano.

### Ejercicio 2: Conversión Hexadecimal

Se implementó el patrón `"0x"[a-fA-F0-9]+` en el escáner. La conversión se realiza con `strtol(yytext, NULL, 16)`, permitiendo operar decimales y hexadecimales simultáneamente.

### Ejercicio 3: Ambigüedad del Operador "|"

El uso de `|` como valor absoluto y operador OR genera un conflicto **Shift/Reduce**. Se resuelve definiendo la precedencia en Bison o reestructurando la gramática para distinguir entre operadores unarios y binarios.

### Ejercicio 6: Escáner Manual vs Flex

Aunque `comparativa_c_ejercicio_6.y` tiene extensión `.y`, contiene código C puro. Se utiliza para demostrar que, si bien un programa escrito a mano puede ser marginalmente más rápido, la mantenibilidad de Flex (basada en DFAs) es superior para lenguajes complejos.

---

## 4. Limpieza de Archivos

Elimine todos los archivos temporales y binarios generados:

```bash
rm -f lex.yy.c *.tab.c *.tab.h wc_flex traductor tokens3 calc_hex calc_com calc_ambig calc_completa wc_c_puro

```

---

**Autor:** Juan Lozano

**Institución:** Universidad Sergio Arboleda

**Fecha:** Febrero 2026
