%{
#include "calculadora_ejercicio_2.tab.h"
%}

%%
"0x"[a-fA-F0-9]+ { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }
[0-9]+           { yylval = atoi(yytext); return NUMBER; }
"+"              { return ADD; }
"-"              { return SUB; }
"*"              { return MUL; }
"/"              { return DIV; }
"|"              { return ABS; }
"#"              { /* Comentario: ignorar hasta fin de línea */ 
                   int c; while((c = input()) != '\n' && c != EOF); }
\n               { return EOL; }
[ \t]            { /* ignorar espacios */ }
.                { return yytext[0]; }
%%

int yywrap() { return 1; }
