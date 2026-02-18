%{
#include "calculadora_ejercicio_2.tab.h"
%}

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n      { return EOL; }
[ \t]   { /* ignore */ }
.       { printf("Misterio %c\n", *yytext); }
%%
int yywrap() { return 1; }
