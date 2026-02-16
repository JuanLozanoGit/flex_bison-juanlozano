%{
#include "ejercicio2.tab.h"
%}

%%
"0x"[a-fA-F0-9]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; }
[0-9]+           { yylval = atoi(yytext); return NUMBER; }
\n               { return EOL; }
[ \t]            { /* ignorar */ }
.                { return yytext[0]; }
%%
