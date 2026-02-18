%{
#include "calculadora_ejercicio_2.tab.h"
#include <stdlib.h>
%}

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }

/* Ejercicio 2: Soporte Hexadecimal */
0x[a-fA-F0-9]+ { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }

\n      { return EOL; }

/* Ejercicio 1: Ignorar comentarios que empiezan con # */
"#".* { /* ignorar comentarios */ }

[ \t]   { /* ignorar espacios */ }
.       { printf("Misterio %c\n", *yytext); }
%%

int yywrap() { return 1; }
