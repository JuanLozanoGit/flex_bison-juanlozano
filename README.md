# README: Flex & Bison (Capítulo 1)

Este repositorio contiene el código fuente y la documentación técnica de los ejemplos y ejercicios del primer capítulo del libro "Flex & Bison" de John Levine. El objetivo principal es comprender la separación de responsabilidades en la construcción de un compilador: el análisis léxico (identificación de tokens) y el análisis sintáctico (validación de gramática).

## 1. Configuración del Entorno de Desarrollo

Para compilar y ejecutar los archivos en un entorno Linux, es indispensable contar con el generador de escáneres **Flex**, el generador de parsers **Bison** y el compilador **GCC**.

### Instalación de herramientas

Ejecute el siguiente comando para asegurar que dispone de todas las dependencias:

```bash
sudo apt update && sudo apt install flex bison build-essential

```

### Acceso y Localización de Archivos

Si ha descargado el proyecto en su carpeta de descargas, utilice los siguientes comandos para posicionarse en el directorio correcto y verificar la existencia de los archivos:

```bash
cd ~/Downloads/flex_bison-juanlozano
pwd
ls -l

```

---

## 2. Guía de Compilación y Ejecución

La arquitectura de estas herramientas requiere procesar primero los archivos de definición para generar código fuente en C que luego será compilado.

### A. Análisis Léxico (Archivos `.l`)

Estos archivos definen patrones mediante expresiones regulares que Flex convierte en un analizador de caracteres.

* **Contador de Palabras (Ejemplo 1-1):**
```bash
flex contador_de_palabras_ejemplo1.l
gcc lex.yy.c -o wc_flex -lfl
./wc_flex < prueba_wc.txt

```


* **Traductor de Variantes de Inglés (Ejemplo 1-2):**
```bash
flex traductor_ingles_ejemplo_2.l
gcc lex.yy.c -o traductor -lfl
./traductor < prueba_traductor.txt

```



### B. Análisis Sintáctico (Integración `.y` + `.l`)

Bison define la gramática y utiliza a Flex como proveedor de tokens. Para estos casos, se deben abrir y procesar ambos archivos para generar un único ejecutable.

* **Calculadora con Manejo de Comentarios (Ejercicio 1):**
```bash
bison -d comentario_ejercicio_1.y
flex escaner_tokens_ejemplo_4.l
gcc comentario_ejercicio_1.tab.c lex.yy.c -o calc_com -lfl

```


* **Calculadora Hexadecimal (Ejercicio 2):**
```bash
bison -d calculadora_ejercicio_2.y
flex escaner_tokens_ejemplo_4.l
gcc calculadora_ejercicio_2.tab.c lex.yy.c -o calc_hex -lfl

```



---

## 3. Resolución Detallada de Ejercicios

### Ejercicio 1: Soporte de Comentarios

* **Problema:** Originalmente, la calculadora fallaba al encontrar una línea que solo contenía un comentario, pues el escáner ignora el texto pero el parser recibe un fin de línea (`EOL`) inesperado.
* **Solución:** Se modificó la gramática en `comentario_ejercicio_1.y` para permitir que la regla `calclist` acepte un `EOL` solitario. Esto permite procesar líneas vacías o comentarios sin generar errores de sintaxis.

### Ejercicio 2: Conversión Hexadecimal

* **Implementación:** Se agregó el patrón `0x[a-fA-F0-9]+` en el escáner.
* **Lógica:** La conversión de la cadena de texto a un valor entero se realiza mediante la función `strtol(yytext, NULL, 16)`. Esto permite que el parser realice operaciones aritméticas transparentes entre números decimales y hexadecimales.

### Ejercicio 3: Ambigüedad del Operador "|"

* **Diagnóstico:** El uso del símbolo `|` tanto para el valor absoluto (unario) como para el operador binario OR genera un conflicto de ambigüedad conocido como **Shift/Reduce**.
* **Análisis:** Ante la entrada `4 | 5`, el parser no puede decidir si cerrar una operación previa o iniciar una binaria. Se requiere el uso de `%left` o `%right` en Bison para definir la precedencia.

### Ejercicio 4 y 6: Escáner Manual vs Flex (Rendimiento)

* **Comparativa:** El escáner manual del Ejemplo 1-4 reconoce los mismos tokens que Flex, pero Flex es superior técnicamente.
* **Justificación:** Flex genera un Autómata Finito Determinista (DFA) optimizado mediante tablas de estados. El código en C puro (`comparativa_c_ejercicio_6.y`) puede ser ligeramente más veloz por carecer de infraestructura adicional, pero es mucho más difícil de escalar y mantener que una definición en Flex.

### Ejercicio 5: Limitaciones de Flex

Flex no es la herramienta adecuada para lenguajes donde:

1. La indentación tiene valor semántico (como en Python).
2. El lenguaje no es regular (requiere memoria de pila compleja para reconocer estructuras).

---

## 4. Limpieza de Archivos

Para eliminar los archivos temporales generados por Flex y Bison (`lex.yy.c`, `*.tab.c`, `*.tab.h`) y los binarios ejecutables, utilice:

```bash
rm -f lex.yy.c *.tab.c *.tab.h wc_flex traductor tokens4 calc_hex calc_com wc_c_puro

```

---

**Autor:** Juan Lozano

**Institución:** Universidad Sergio Arboleda

**Materia:** Compiladores

**Fecha:** Febrero 2026
