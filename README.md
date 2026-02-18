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

### A. Análisis Léxico (Archivos `.l` puros)

Estos archivos generan analizadores que funcionan de forma independiente (tienen su propio `main`).

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

## 3. Resolución Detallada de Ejercicios

### Ejercicio 1: Soporte de Comentarios

Se modificó la gramática en `comentario_ejercicio_1.y` para que la regla `calclist` acepte un `EOL` solitario. El escáner (`.l`) ignora el texto después del símbolo `#`, enviando solo el salto de línea al parser, evitando errores de sintaxis en líneas vacías.

### Ejercicio 2: Conversión Hexadecimal

Se implementó en el escáner el patrón `0x[a-fA-F0-9]+`. La conversión se realiza mediante `strtol(yytext, NULL, 16)`. El parser en `calculadora_ejercicio_2.y` imprime el resultado usando el formato `%d` y `%X` para mostrar decimal y hexadecimal simultáneamente.

### Ejercicio 3: Ambigüedad del Operador "|"

Al usar `|` tanto para valor absoluto (unario) como para una posible operación OR (binario), Bison detecta un conflicto **Shift/Reduce**. Se resolvió mediante la declaración de precedencia:

```yacc
%left ADD SUB
%left MUL DIV
%nonassoc ABS

```

Esto permite que el parser sepa que el valor absoluto tiene mayor prioridad que las operaciones aritméticas básicas.

### Ejercicio 6: Escáner Manual vs Flex

Se rescribió el contador de palabras en C puro. Al comparar `wc_c_puro` contra `wc_flex`, se observa que el código manual es ligeramente más rápido en archivos grandes debido a la ausencia del overhead de la máquina de estados de Flex, aunque es mucho más difícil de mantener y escalar.

---

## 4. Limpieza de Archivos

```bash
rm -f lex.yy.c *.tab.c *.tab.h wc_flex traductor tokens3 calc_hex calc_com calc_ambig wc_c_puro

```

---

**Autor:** Juan Lozano

**Institución:** Universidad Sergio Arboleda

**Fecha:** Febrero 2026
